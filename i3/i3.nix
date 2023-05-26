{ config, pkgs, lib, ... }:
let mod = "Mod4";
in {
  imports = [
    ./i3bars.nix
  ];

  services.picom = {
    enable = true;
#    backend = "glx";
    shadow = true;
    vSync = true;
    settings = {
      corner-radius = 8;
      rounded-corners-exclude = [ "window_type = 'dock'" "window_type = 'desktop'" "class_g = 'rofi'" ];
    };
  };

  services.network-manager-applet.enable = true;

  programs.feh.enable = true;

  programs.i3status-rust.enable = true;

  home.packages = with pkgs; [ i3 xborders xss-lock feh betterlockscreen rofi ];

  home.file = { ".config/i3/config".source = ./i3.config; };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = "0";
        follow = "keyboard";
        width = "500";
        height = "300";
        origin = "top-left";
        offset = "10x30";
        progress_bar = "true";
        progress_bar_height = "12";
        transparency = "0";
        padding = "8";
        horizontal_padding = "8";
        frame_color = "#aaaaaa";
        sort = "yes";
        font = "Monospace 12";
        line_height = "0";
        alignment = "left";
        show_age_threshold = "60";
        icon_position = "left";
        history_length = "100";
        dmenu = "${pkgs.rofi}/bin/rofi -P dunst:";
        corner_radius = "7";
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "context, close_current";
        mouse_right_click = "close_all";
      };
      urgency_low = {
        background = "#282a36";
        foreground = "#888888";
        timeout = "8";
      };
      urgency_normal = {
        background = "#282a36";
        foreground = "#ffffff";
        timeout = "8";
      };
      urgency_critical = {
        background = "#282a36";
        foreground = "#ffffff";
        frame_color = "#ff0000";
        timeout = "0";
      };
    };
  };


  #  xsession.windowManager.i3 = {
  #    enable = false;
  #    package = pkgs.i3;
  #    config = {
  #      bars = [];
  #
  #      modifier = mod;
  #      floating.modifier = mod;
  #
  #      # Disable border of windows
  #      window.commands = [
  #        {
  #          command = "border pixel 0";
  #          criteria = {
  #            class = "^.*";
  #          };
  #        }
  #      ];
  #
  #      gaps = {
  #        inner = 10;
  #        outer = -2;
  #        smartGaps = false;
  #      };
  #
  #      keybindings =  {
  #        # terminal
  #        "${mod}+Return" = "exec xfce4-terminal";
  #
  #        # Rofi
  #        "${mod}+i" = "exec --no-startup-id rofi -show run";
  #        "Mod1+Tab" = "exec --no-startup-id rofi -show window";
  #
  #        # lock
  #        "Control+Mod1+l" = "exec --no-startup-id betterlockscreen -l -- -n -f";
  #
  #        # kill windows
  #        "${mod}+q" = "kill";
  #
  #        # change focus
  #        "${mod}+t" = "focus left";
  #        "${mod}+s" = "focus down";
  #        "${mod}+r" = "focus up";
  #        "${mod}+n" = "focus right";
  #
  #        # alternatively, you can use the cursor keys:
  #        "${mod}+Left" = "focus left";
  #        "${mod}+Down" = "focus down";
  #        "${mod}+Up" = "focus up";
  #        "${mod}+Right" = "focus right";
  #
  #        # move focused window
  #        "${mod}+Shift+t" = "move left";
  #        "${mod}+Shift+s" = "move down";
  #        "${mod}+Shift+r" = "move up";
  #        "${mod}+Shift+n" = "move right";
  #
  #        # alternatively, you can use the cursor keys:
  #        "${mod}+Shift+Left" = "move left";
  #        "${mod}+Shift+Down" = "move down";
  #        "${mod}+Shift+Up" = "move up";
  #        "${mod}+Shift+Right" = "move right";
  #
  #        # switch to workspace
  #		"${mod}+quotedbl" = "workspace number 1";
  #		"${mod}+guillemotleft" = "workspace number 2";
  #		"${mod}+guillemotright" = "workspace number 3";
  #		"${mod}+parenleft" = "workspace number 4";
  #		"${mod}+parenright" = "workspace number 5";
  #		"${mod}+at" = "workspace number 6";
  #		"${mod}+plus" = "workspace number 7";
  #		"${mod}+minus" = "workspace number 8";
  #		"${mod}+slash" = "workspace number 9";
  #		"${mod}+asterisk" = "workspace number 10";
  #		"${mod}+degree" = "workspace number 11";
  #		"${mod}+grave" = "workspace number 12";
  #
  #        # move focused container to workspace
  #		"${mod}+Shift+quotedbl" = "move container to workspace number 1";
  #		"${mod}+Shift+guillemotleft" = "move container to workspace number 2";
  #		"${mod}+Shift+guillemotright" = "move container to workspace number 3";
  #		"${mod}+Shift+4" = "move container to workspace number 4";
  #		"${mod}+Shift+5" = "move container to workspace number 5";
  #		"${mod}+Shift+at" = "move container to workspace number 6";
  #		"${mod}+Shift+plus" = "move container to workspace number 7";
  #		"${mod}+Shift+minus" = "move container to workspace number 8";
  #		"${mod}+Shift+slash" = "move container to workspace number 9";
  #		"${mod}+Shift+asterisk" = "move container to workspace number 10";
  #		"${mod}+Shift+degree" = "move container to workspace number 11";
  #		"${mod}+Shift+grave" = "move container to workspace number 12";
  #
  #        # move focused workspace
  #		"${mod}+Control+t" = "move workspace to output right";
  #		"${mod}+Control+n" = "move workspace to output left";
  #		"${mod}+Control+r" = "move workspace to output down";
  #		"${mod}+Control+s" = "move workspace to output up";
  #		"${mod}+Control+c" = "exec i3-input -F 'rename workspace to \"%s\"' -P 'New name: '";
  #
  #        # split in horizontal orientation
  #        "${mod}+c" = "split h";
  #        # split in vertical orientation
  #        "${mod}+period" = "split v";
  #
  #        # enter fullscreen mod for the focused container
  #        "${mod}+e" = "fullscreen toggle";
  #
  #        # change container layout (stacked, tabbed, toggle split)
  #        "${mod}+u" = "layout stacking";
  #        "${mod}+eacute" = "layout tabbed";
  #        "${mod}+p" = "layout toggle split";
  #
  #        # toggle tiling / floating
  #        "${mod}+Shift+space" = "floating toggle";
  #        # change focus between tiling / floating windows
  #        "${mod}+space" = "focus mod_toggle";
  #
  #        # focus the parent container
  #        "${mod}+a" = "focus parent";
  #        # focus the child container
  #        "${mod}+d" = "focus child";
  #
  #        # reload the configuration file
  #        "${mod}+Shift+x" = "reload";
  #        # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
  #        "${mod}+Shift+o" = "restart";
  #        # exit i3 (logs you out of your X session)
  #        "${mod}+Shift+p" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you rea lly want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'\"";
  #
  #        # Scratchpad
  #        "${mod}+Shift+ccedilla" = "move scratchpad";
  #        "${mod}+ccedilla" = "scratchpad show";
  #
  #        # trigger resize mode
  #        "${mod}+o" = "mode \"resize\"";
  #        };
  #
  #        modes = {
  #          resize = {
  #            "t" = "resize shrink width 10 px or 10 ppt";
  #            "s" = "resize grow height 10 px or 10 ppt";
  #            "r" = "resize shrink height 10 px or 10 ppt";
  #            "n" = "resize grow width 10 px or 10 ppt";
  #
  #            # same bindings, but for the arrow keys
  #            "Left" = "resize shrink width 10 px or 10 ppt";
  #            "Down" = "resize grow height 10 px or 10 ppt";
  #            "Up" = "resize shrink height 10 px or 10 ppt";
  #            "Right" = "resize grow width 10 px or 10 ppt";
  #
  #            # back to normal: Enter or Escape or $mod+r
  #            "Return" = "mode \"default\"";
  #            "Escape" = "mode \"default\"";
  #            "$mod+o" = "mode \"default\"";
  #            };
  #          };
  #        };
  #    extraConfig = ''
  ### Execs
  #
  ## xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
  ## screen before suspend. Use loginctl lock-session to lock your screen.
  #exec --no-startup-id xss-lock --transfer-sleep-lock -- betterlockscreen -l -- -n -f
  #
  #exec --no-startup-id source ~/.fehbg
  #
  ## xborders sets a nice border for windows
  #exec_always --no-startup-id pkill xborders
  #exec_always --no-startup-id sleep 1 && xborders --disable-version-warning --border-rgba=#0069ffff --border-width 3 --border-radius 10
  #'';
  #  };
}
