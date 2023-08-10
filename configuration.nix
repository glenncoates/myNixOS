# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      home-manager.nixosModules.home-manager
      ./hardware-configuration.nix
      ./packages.nix
      ./doc.nix
      ./home.nix
    ];

  # Setup for Nix Flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = '' 
    experimental-features = nix-command flakes
  '';

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # QEMU-specific
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # For using wide screen monitor!
  services.logind.lidSwitchExternalPower = "ignore";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
#  users.users.user = {
#    isNormalUser = true;
#    description = "user";
#    extraGroups = [ "networkmanager" "wheel" ];
#    packages = with pkgs; [
#      firefox
#    #  thunderbird
#    ];
#  };

  users = 
  {
    # Enable this if you wish to change user settings (including
    # passwords) outside of the nix configuration.
    # This is needed so we can set users up via Home Manager.
    mutableUsers = false;

    users.user = 
    {
      isNormalUser = true;

      # Generate the hashed password by running `mkpassword` on the
      # command line.
      hashedPassword = "$y$j9T$3TPJg69jmtW6lLhtB14qU1$gfKSmUE91n0NauUjrJyWkFQUhLeUh9MhZ2TczjYKFh3";
      	
      # Some extra groups that I've found it is useful to be added to.
      extraGroups = 
      [
        "wheel"
        "networkmanager"
        "video"
        "wireshark"
        "libvirtd"
        "cdrom"
        "dialout"
        "audio"
        "pulse"
        "libvirtd"
        "plugdev"
        "scanner"
        "lp"
        "input"
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "user";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; 
  [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    vimHugeX
    # browser
    chromium
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  #services.openssh = 
  #{
  #  enable = true;
  #  settings = 
  #  {
  #    kexAlgorithms = [ "curve25519-sha256" ];
  #    ciphers = [ "chacha20-poly1305@openssh.com" ];
  #    passwordAuthentication = false;
  #    permitRootLogin = "no"; # do not allow to login as root user
  #    kbdInteractiveAuthentication = false;
  #  };
  #};
  

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
