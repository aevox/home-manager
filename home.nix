{ config, pkgs, lib, ... }: {
  imports = [
    ./nvim/nvim.nix
    ./gnome/gnome.nix
    ./zsh/zsh.nix
    ./gnome/gnome.nix

    ./dotfiles/dotfiles.nix
  ]
  ++ (if builtins.getEnv "HOME" == "/home/knwk3963" then
        [ ./work.nix ]
      else
        []);

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
    fd
    xclip
    unrar
    tmux
    k9s
    # kubectl # Given by toolbox

    # Languages
    gcc
    go
    gopls
    universal-ctags

    python3Full
    python310Packages.ipython
    python310Packages.virtualenv
    python310Packages.pip
    python310Packages.flake8

    # Apps
    rofi
    libreoffice
    okular
    thunderbird
    texlive.combined.scheme-full

    firefox
    chromium
    google-chrome
    youtube-music
    whatsapp-for-linux

    rocketchat-desktop
    jitsi-meet-electron
    teams
    discord
    variety

    docker
    docker-compose

    (nerdfonts.override { fonts = [ "Hack" "DroidSansMono" "Ubuntu"]; })
  ];

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

  programs.alacritty = {
    enable = true;
    settings = {
      history = "100000";
      window = {
        opacity = 0.9;
        decorations = "none";
      };
      cursor.style.blinking = "On";
      font = {
        size = 12;
        normal = {
          family = "Hack Nerd Font Mono";
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
          red = "0xFF301B";
          green = "0xA0E521";
          yellow = "0xFFC620";
          blue = "0x1D7FF3";
          magenta = "0x8763B8";
          cyan = "0x21DEEF";
          white = "0xe5e5e5";
        };
        bright = {
          black = "0x7f7f7f";
          red = "0xFF4352";
          green = "0xB8E466";
          yellow = "0xFFD750";
          blue = "0x1BA6FA";
          magenta = "0xA578EA";
          cyan = "0x73FBF1";
          white = "0xffffff";
        };
      };
    };
  };
}
