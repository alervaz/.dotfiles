# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: { imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true; networking.hostName = "nixos"; # Define your hostname. networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "This is censored ;)";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
i18n.extraLocaleSettings = { LC_ADDRESS = "es_PR.UTF-8";
    LC_IDENTIFICATION = "es_PR.UTF-8";
    LC_MEASUREMENT = "es_PR.UTF-8";
    LC_MONETARY = "es_PR.UTF-8";
    LC_NAME = "es_PR.UTF-8";
    LC_NUMERIC = "es_PR.UTF-8";
    LC_PAPER = "es_PR.UTF-8";
    LC_TELEPHONE = "es_PR.UTF-8";
    LC_TIME = "es_PR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #services.xserver.desktopManager.default = "none";ures
  services.xserver.desktopManager = {
	  xterm.enable = false;
	  gnome.enable = true;
  };

  services.xserver.displayManager = {
	lightdm.enable = false;
	gdm.enable = true;
	defaultSession = "none+i3";
};
  #services.xserver.desktopManager.xterm.enable = false;
  #services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;

  # Enable the GNOME Desktop Environment.

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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alerv = {
    isNormalUser = true;
    description = "A** V***";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
	#nodePackages.pyright
	#nil
      firefox
	      discord
	      neovim
	      rofi
	      picom
	      tmux
	      polybar
	      alacritty
        kitty
	      starship
	      nil
        thefuck
        arandr

#  thunderbird
    ];
  };

programs.steam.enable = true;
# Allow unfree packages
nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
environment.systemPackages = with pkgs; [
#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#  wget
	pulseaudio
  home-manager
  networkmanagerapplet
	gcc13
	xclip
	wget
	unzip
	brightnessctl
	killall
	#nodejs
	  # NPM packages
];

xdg.portal.enable = true;
#xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };
programs.zsh = {
	enable = true;
};
users.defaultUserShell = pkgs.zsh;
programs.git.enable = true;

#gtk.enable = true;

#gtk.cursorTheme.package = pkgs.bibata-cursors;
#gtk.cursorTheme.name = "Bibata-Modern-Ice";

#gtk.theme.package = pkgs.adw-gtk3;
#gtk.theme.name = "adw-gtk3";

#gtk.iconTheme.package = pkgs.gruvboxPlus;
#gtk.iconTheme.name = "GruvboxPlus";#qt.enable = true;
# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

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
