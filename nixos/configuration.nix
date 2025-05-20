# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      alerv = import ./home.nix;
    };
  };

  time.hardwareClockInLocalTime = true;

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  hardware.opengl.enable = true;
    # Enable intel video driver
  services.xserver.videoDrivers = [ "modesetting" ];
  services.flatpak.enable = true;


  # For wine32 bit
  hardware.opengl.driSupport32Bit = true;


#boot.loader.grub.enable = true;
#boot.loader.grub.device = "/dev/sda";
#boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
    networking.networkmanager.enable = true;

# Set your time zone.
  time.timeZone = "America/Puerto_Rico";

# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  qt.enable = false;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "es_PR.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

# Enable the X11 windowing system.
  services.xserver.enable = true;

# Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.hyprland = {
    enable = true;
  };

  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
    };
  };

# Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

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
  users.users.alerv = {
    isNormalUser = true;
    description = "Name";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    firefox
    kitty
        discord
        neovim
        steam
        thunderbird
    ];
    shell = pkgs.zsh;
  };

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes"];

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
  thefuck
  whitesur-kde
  prismlauncher
      pkgs.bibata-cursors
    pkgs.networkmanagerapplet
    pkgs.gcc13
    pkgs.brightnessctl
    pkgs.killall
    libglvnd
    pulseaudio
        ripgrep
      pkgs.jetbrains.goland
      pkgs.jetbrains.phpstorm
      pkgs.jetbrains.clion
      pkgs.jetbrains.rust-rover
#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#  wget
      vim
      home-manager
      pkgs.man-pages 
      pkgs.man-pages-posix
  ];

  programs.zsh.enable = true;
  documentation.dev.enable = true;


# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;
#services.openssh.enable = true;


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
  system.stateVersion = "23.11"; # Did you read the comment?

}
