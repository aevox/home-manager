{ config, pkgs, ... }:
{
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
}
