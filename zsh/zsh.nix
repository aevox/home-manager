{ config, pkgs, ... }:

{
  # To make default shell on ubuntu :
  # Add `/home/$USER/.nix-profile/bin/zsh` to /etc/shells, then
  # `chsh -s $(which zsh)`
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    history = {
      save = 999999;
      size = 999999;
    };

    initExtraFirst = ''
      # p10k instant prompt
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "kubectl" "golang" "web-search"];
    };

    plugins = with pkgs; [
      {
        name = "powerlevel10k";
        file = "powerlevel10k.zsh-theme";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      {
        name = "powerlevel10k-config";
        file = "p10k.zsh";
        src = ./.;
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.6.0";
          sha256 = "0r73i9jbxqmbra7cxms0r3ickkymg1c1n4nc3ywvjzcyiac9sj87";
        };
      }
      {
        name = "zsh-fast-syntax-highlighting";
        src = "${zsh-fast-syntax-highlighting}";
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
    ];
  };

  programs.starship = {
    enable = false;
    enableZshIntegration = true;
    settings = {
      right_format = "$cmd_duration";
      add_newline = false;
      directory = {
        truncation_length = 4;
        truncate_to_repo = false;
        style = "blue";
        before_repo_root_style = "blue";
        repo_root_style = "bold blue";
        truncation_symbol = "…/";
      };
      time = {
        disabled = true;
        format = "\[$time\]($style)";
      };
      cmd_duration = {
        format = "[$duration]($style)";
      };
      nix_shell = {
        symbol = "❄️ ";
        format = "[$symbol$state(\\($name\\))]($style)";
      };
      git_branch = {
        symbol = "";
        format = "[$symbol$branch(:$remote_branch)]($style)";
      };
    };
  };
}
