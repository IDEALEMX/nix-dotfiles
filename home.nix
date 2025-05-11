{ config, pkgs, lib, ... }:

let
  terminal = "kitty";
  browser = "firefox";
in

{
  # home-manager config
  home.username = "ideale";
  home.homeDirectory = "/home/ideale";
  nixpkgs.config.allowUnfree = true;

  # make fonts avaliable
  fonts.fontconfig.enable = true;

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

    # for haskell
    pkgs.haskell.compiler.ghc94
    pkgs.cabal-install
    
    # discord
    pkgs.discord-ptb

    # fonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

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

  # @bash config
  programs.bash = {
    enable = true;
    shellAliases = {
      "battery" = "acpi";
      "vi" = "~/.nixvim/result/bin/nvim";
      "bupdates" = "bash ~/.nix/bupdates.sh";
    };

    # prompt
    initExtra = ''
      PS1="\[\e[1;32m\][\u@\h]\[\e[1;34m\]\w \n理想\[\e[0m\]| "
    '';
  };

  # @kitty terminal
  programs.kitty = {
    enable = true;
    font = {
      size = 14;
      name = "JetBrainsMonoNF-Regular";
    };

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

  # @hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # set modkey
      "$mod" = "SUPER";
      
      # monitor settings
      monitor = [ ",highres,auto,1" ];

      exec-once = [ "waybar" ];

      bind = [
        # program binds
        "$mod, K, exec, ${terminal}"
	"$mod, I, exec, ${browser}"

	# functionality binds
	"$mod, L, killactive"
	"$mod, Q, exit"

	# workspace binds
	"$mod, 1, workspace, 1"
	"$mod, 2, workspace, 2"
	"$mod, 3, workspace, 3"
	"$mod, 4, workspace, 4"
	"$mod, 5, workspace, 5"
	"$mod, 6, workspace, 6"
	"$mod, 7, workspace, 7"
	"$mod, 8, workspace, 8"
	"$mod, 9, workspace, 9"

	"$mod SHIFT, 1, movetoworkspace, 1"
	"$mod SHIFT, 2, movetoworkspace, 2"
	"$mod SHIFT, 3, movetoworkspace, 3"
	"$mod SHIFT, 4, movetoworkspace, 4"
	"$mod SHIFT, 5, movetoworkspace, 5"
	"$mod SHIFT, 6, movetoworkspace, 6"
	"$mod SHIFT, 7, movetoworkspace, 7"
	"$mod SHIFT, 8, movetoworkspace, 8"
	"$mod SHIFT, 9, movetoworkspace, 9"
      ];

      input = { natural_scroll = true; };

    };
  };

  # @waybar
  programs.waybar = {
    enable = true;

    #=== config inspired by ===#
    #=== https://github.com/cjbassi/config/tree/master ===#

    style = '' 
      * {
      	font-size: 20px;
      	font-family: monospace;
      }
      
      window#waybar {
      	background: #292b2e;
      	color: #fdf6e3;
      }
      
      #custom-right-arrow-dark,
      #custom-left-arrow-dark {
      	color: #1a1a1a;
      }
      #custom-right-arrow-light,
      #custom-left-arrow-light {
      	color: #292b2e;
      	background: #1a1a1a;
      }
      
      #workspaces,
      #clock.1,
      #clock.2,
      #clock.3,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk,
      #tray {
      	background: #1a1a1a;
      }
      
      #workspaces button {
      	padding: 0 2px;
      	color: #fdf6e3;
      }
      #workspaces button.focused {
      	color: #268bd2;
      }
      #workspaces button:hover {
      	box-shadow: inherit;
      	text-shadow: inherit;
      }
      #workspaces button:hover {
      	background: #1a1a1a;
      	border: #1a1a1a;
      	padding: 0 3px;
      }
      
      #pulseaudio {
      	color: #268bd2;
      }
      #memory {
      	color: #2aa198;
      }
      #cpu {
      	color: #6c71c4;
      }
      #battery {
      	color: #859900;
      }
      #disk {
      	color: #b58900;
      }
      
      #clock,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk {
      	padding: 0 10px;
      }
    '';
    
    settings = [{
      layer = "top";
      position = "top";

      "modules-left" = [
        "sway/workspaces"
        "custom/right-arrow-dark"
      ];

      "modules-center" = [
        "custom/left-arrow-dark"
        "clock#1"
        "custom/left-arrow-light"
        "custom/left-arrow-dark"
        "clock#2"
        "custom/right-arrow-dark"
        "custom/right-arrow-light"
        "clock#3"
        "custom/right-arrow-dark"
      ];

      "modules-right" = [
        "custom/left-arrow-dark"
        "pulseaudio"
        "custom/left-arrow-light"
        "custom/left-arrow-dark"
        "memory"
        "custom/left-arrow-light"
        "custom/left-arrow-dark"
        "cpu"
        "custom/left-arrow-light"
        "custom/left-arrow-dark"
        "battery"
        "custom/left-arrow-light"
        "custom/left-arrow-dark"
        "disk"
        "custom/left-arrow-light"
        "custom/left-arrow-dark"
        "tray"
      ];

      "custom/left-arrow-dark" = {
        format = "";
        tooltip = false;
      };

      "custom/left-arrow-light" = {
        format = "";
        tooltip = false;
      };

      "custom/right-arrow-dark" = {
        format = "";
        tooltip = false;
      };

      "custom/right-arrow-light" = {
        format = "";
        tooltip = false;
      };

      "sway/workspaces" = {
        "disable-scroll" = true;
        format = "{name}";
      };

      "clock#1" = {
        format = "{:%a}";
        tooltip = false;
      };

      "clock#2" = {
        format = "{:%H:%M}";
        tooltip = false;
      };

      "clock#3" = {
        format = "{:%m-%d}";
        tooltip = false;
      };

      pulseaudio = {
        format = "{icon} {volume:2}%";
        "format-bluetooth" = "{icon}  {volume}%";
        "format-muted" = "MUTE";
        "format-icons" = {
          headphones = "";
          default = [ "" "" ];
        };
        "scroll-step" = 5;
        "on-click" = "pamixer -t";
        "on-click-right" = "pavucontrol";
      };

      memory = {
        interval = 5;
        format = "Mem {}%";
      };

      cpu = {
        interval = 5;
        format = "CPU {usage:2}%";
      };

      battery = {
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        "format-icons" = [ "" "" "" "" "" ];
      };

      disk = {
        interval = 5;
        format = "Disk {percentage_used:2}%";
        path = "/";
      };

      tray = {
        "icon-size" = 20;
      };
    }];

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
