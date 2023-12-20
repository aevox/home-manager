{ config, pkgs, lib, ... }:
let
  hostnameFile = builtins.readFile "/proc/sys/kernel/hostname";
  hostname = builtins.elemAt (builtins.split "\n" hostnameFile) 0;
in {
  imports = [
    ./machines/${hostname}.nix

    ./nvim/nvim.nix
    ./zsh/zsh.nix
    ./dotfiles/dotfiles.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = lib.mkDefault "marc";
  home.homeDirectory = lib.mkDefault "/home/marc";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Shell tools
    httpie
    wget
    curl
    nmap
    unixtools.netstat
    tree
    htop
    xorg.xev
    xorg.xkill

    jq
    yq
    yamllint

    gnumake

    tig
    bat

    cheat
    silver-searcher
    ripgrep
    fd
    xclip
    unrar
    tmux
    k9s
    # kubectl # Given by toolbox

    # Languages
    gcc
    gopls
    universal-ctags

    python311Full
    python311Packages.ipython
    python311Packages.virtualenv
    python311Packages.pip
    python311Packages.flake8
    python311Packages.rope
    python311Packages.pylint
    python311Packages.autopep8
    python311Packages.jedi

    # Apps
    xfce.xfce4-terminal
    libreoffice
    okular
    thunderbird
    #texlive.combined.scheme-full

    firefox
    chromium
    google-chrome
    whatsapp-for-linux
    teams-for-linux

    rocketchat-desktop
    jitsi-meet-electron
    discord
    variety

    docker
    docker-compose

    (nerdfonts.override { fonts = ["Hack" "Noto" "DroidSansMono"]; })
    arc-theme
    papirus-icon-theme
  ];

  programs.go.enable = true;

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Marc Fouché";
    userEmail = lib.mkDefault "fouche.marc@gmail.fr";
    extraConfig = {
      pull.ff = "only";
      url."git@git.corp.caascad.com:caascad".insteadOf = "git@git.corp.cloudwatt.com:caascad";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = ''ag --hidden -g \"\"'';
    fileWidgetCommand = ''ag --hidden -g \"\"'';
    fileWidgetOptions = [ "--preview 'bat -p --color=always --line-range :500 {}'" ];
    changeDirWidgetCommand = ''fd --type d --hidden --follow --exclude \".git\"'';
    changeDirWidgetOptions = [ "--preview 'tree -C -L 2 {} | head -200'" ];
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };

  # Beware that pinentry-gnome3 may not work on non-Gnome systems.
  # You can fix it by adding the following to your system configuration:
  # services.dbus.packages = [pkgs.gcr];
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    pinentryFlavor = "tty";
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      font_size = "12";
      window_padding_width = "4";
      enable_audio_bell = "no";
      font_family = "Hack Nerd Font Regular";
      bold_font = "Hack Nerd Bold";
      italic_font = "Hack Nerd Italic";
      bold_italic_font = "Hack Nerd Bold Italic";
      background_opacity = "0.9";
    };
    keybindings = {
      "alt+up" = "send_text all \\x1b[A"; # Make alt + arrow = arrow
      "alt+down" = "send_text all \\x1b[B";
      "alt+right" = "send_text all \\x1b[C";
      "alt+left" = "send_text all \\x1b[D";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      history = "100000";
      window = {
        padding = {
          x = 4;
          y = 4;
        };
        opacity = 0.9;
      };
      cursor = {
        style = {
          blinking = "Always";
        };
      };
      font = {
        size = 12;
        normal = {
          family = "Hack Nerd Font";
        };
      };
      mouse = {
        hide_when_typing = true;
      };
      colors = {
        primary = {
          background = "0x000000";
          foreground = "0xffffff";
        };
        normal = {
          black = "0x000000";
          red = "0xcc0403";
          green = "0x19cb00";
          yellow = "0xcecb00";
          blue = "0x0d73cc";
          magenta = "0xcb1ed1";
          cyan = "0x0dcdcd";
          white = "0xdddddd";
        };
        bright = {
          black = "0x767676";
          red = "0xf2201f";
          green = "0x23fd00";
          yellow = "0xfffd00";
          blue = "0x1a8fff";
          magenta = "0xfd28ff";
          cyan = "0x0dcdcd";
          white = "0xffffff";
        };
      };
    };
  };
}
