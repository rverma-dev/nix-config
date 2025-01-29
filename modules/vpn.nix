# VPN configuration
{ config, lib, pkgs, vars, ... }:

{
  # Install OpenVPN
  environment.systemPackages = with pkgs; [
    openvpn
  ];

  # Copy the OpenVPN configuration file
  home-manager.users.${vars.user} = {
    home.file.".config/openvpn/aws.ovpn".source = ../files/vpn/aws.ovpn;
    
    # Create a credentials file (you'll need to fill this manually)
    home.file.".config/openvpn/credentials".text = ''
      # Add your credentials here in two lines:
      # username
      # password
    '';
  };

  # Create the OpenVPN service
  launchd.user.agents.openvpn-aws = {
    path = [ pkgs.openvpn ];
    serviceConfig = {
      Label = "com.openvpn.aws";
      ProgramArguments = [
        "${pkgs.openvpn}/bin/openvpn"
        "--config"
        "/Users/${vars.user}/.config/openvpn/aws.ovpn"
        "--auth-user-pass"
        "/Users/${vars.user}/.config/openvpn/credentials"
        "--script-security"
        "2"     # Allow running scripts
      ];
      RunAtLoad = true;      # Start at login
      KeepAlive = true;      # Restart on failure
      StandardOutPath = "/Users/${vars.user}/.config/openvpn/openvpn.log";
      StandardErrorPath = "/Users/${vars.user}/.config/openvpn/openvpn.error.log";
      EnvironmentVariables = {
        PATH = lib.mkForce "${pkgs.openvpn}/bin:${config.environment.systemPath}";
      };
    };
  };

  # Create required directories and set permissions
  system.activationScripts.preActivation.text = ''
    mkdir -p /Users/${vars.user}/.config/openvpn
    chmod 700 /Users/${vars.user}/.config/openvpn
    touch /Users/${vars.user}/.config/openvpn/credentials
    chmod 600 /Users/${vars.user}/.config/openvpn/credentials
  '';
} 