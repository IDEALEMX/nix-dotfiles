{ config, pkgs, ... }:

let
  fontname = "Arial";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ideale";
  home.homeDirectory = "/home/ideale";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ideale/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # bash config
  programs.bash = {
    enable = true;
    shellAliases = {
      "battery" = "acpi";
    };

    # prompt
    initExtra = ''
      PS1="\[\e[1;32m\][\u@\h]\[\e[1;34m\]\w \n理想\[\e[0m\]| "
    '';
  };

  # kitty terminal
  programs.kitty = {
    enable = true;
    font.size = 14;
    font.name = "Hack";

    # prevents bash from overwritting the cursor_shape property
    shellIntegration.enableBashIntegration = false;
	
    settings = {
      # opacity
      dynamic_background_opacity = "yes";
      background_opacity = 0.7;

      # cursor settings
      cursor_trail = 3;
      cursor_blink_interval = 0;
      cursor_shape_unfocused = "unchanged";
      shell_integration = "no-cursor";
      cursor_shape = "block";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
