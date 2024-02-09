{ config, pkgs, ... }:

{
# Home Manager needs a bit of information about you and the paths it should
# manage.
  home.username = "alerv";
  home.homeDirectory = "/home/alerv";

# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

# The home.packages option allows you to install Nix packages into your
# environment.
    home.packages = [
    pkgs.wofi
      pkgs.tmux
      pkgs.waybar
      pkgs.pywal
      pkgs.swaybg
      pkgs.grim
      pkgs.slurp
      pkgs.nil
      pkgs.wl-clipboard
      pkgs.obs-studio
      pkgs.bibata-cursors
      pkgs.adw-gtk3
      pkgs.superTuxKart
       pkgs.rustup
       pkgs.go
# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

# # You can also create simple shell scripts directly inside your
# # configuration. For example, this adds a command 'my-hello' to your
# # environment:
# (pkgs.writeShellScriptBin "my-hello" ''
#   echo "Hello, ${config.home.username}!"
# '')
      ];

  programs.starship = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "alervaz";
    userEmail = "alervaz2008@gmail.com";
  };

  programs.zsh = {
    enable = true;
    plugins = [
    {
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.8.0";
        sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
      };
    }
    ];
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    initExtra = ''
      wal -i ~/Pictures/astronaut.png >> /dev/null
      cat ~/.cache/wal/sequences >> /dev/null
      '';
  };

  programs.alacritty = {
    enable = true;
  };

  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";


#gtk.iconTheme.package = pkgs.gruvboxPlus;
#gtk.iconTheme.name = "GruvboxPlus";





# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
  home.file = {
# # Building this configuration will create a copy of 'dotfiles/screenrc' in
# # the Nix store. Activating the configuration will then make '~/.screenrc' a
# # symlink to the Nix store copy.
# ".screenrc".source = dotfiles/screenrc;

# # You can also set the file content immediately.
# ".gradle/gradle.properties".text = ''
#   org.gradle.console=verbose
#   org.gradle.daemon.idletimeout=3600000
# '';
  };

# You can also manage environment variables but you will have to manually
# source
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/alerv/etc/profile.d/hm-session-vars.sh
#
# if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    GOPATH = "$HOME/go";
    PATH = "$GOPATH/bin:$PATH";
  };

# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
