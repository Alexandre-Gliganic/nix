# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports = [
  ];

  # nixpkgs.overlays = (import ../../overlays);
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkpad"; # Define your hostname.
  networking.networkmanager.enable = true;

  networking.firewall.checkReversePath = "loose";

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  services = {
    blueman.enable = true;
    pcscd.enable = true;
    udev.packages = with pkgs; [ yubikey-personalization ];
    openssh = {
      enable = false;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      displayManager.defaultSession = "xfce+i3";
      windowManager.i3 = { enable = true; };
      xautolock = {
        enable = true;
        locker = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
        nowlocker = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
        time = 4; # autolock after 4 minutes
        killtime = 10; # suspend after 10 minutes
        killer = "${pkgs.systemd}/bin/systemctl suspend";
        extraOptions = [ "-corners 0-0- -cornersize 30" ];
      };
    };
    logind = {
      lidSwitch = "suspend";
      lidSwitchDocked = "suspend";
      lidSwitchExternalPower = "suspend";
      extraConfig = ''
        IdleAction=lock
        HandlePowerKey=ignore
      '';
    };


  };

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;

  environment = {
    systemPackages = with pkgs; [
      firefox
      git
      gnupg
      networkmanagerapplet
      neovim
      vim
      wireguard-tools
      yubikey-personalization
      xsel
    ];
  };


  programs = {
    command-not-found.enable = false;
    dconf.enable = true;
    fish.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
    };
  };
  sound.enable = true;

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };


  security.pki.certificateFiles = [
    ../../resources/OuiDoThings_-_Root_CA.crt
    ../../resources/CoreNinja_-_Root_CA.crt
  ];

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
