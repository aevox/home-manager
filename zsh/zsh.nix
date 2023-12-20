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
      plugins = [ "git" "sudo" "kubectl" "golang" "web-search" ];
    };

    plugins = with pkgs; [
      {
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
        file = "powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        file = "p10k.zsh";
        src = ./.;
      }
      {
        name = "zsh-autosuggestions";
        src = "${zsh-autosuggestions}/share/zsh-autosuggestions";
        file = "zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = "${zsh-nix-shell}/share/zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
      }
      {
        name = "zsh-fast-syntax-highlighting";
        src = "${zsh-fast-syntax-highlighting}/share/zsh/site-functions/";
        file = "fast-syntax-highlighting.plugin.zsh";
      }
    ];
  };

  programs.starship = {
    enable = false;
    enableZshIntegration = true;
    settings = {
      format = "$all$kubernetes$line_break$character";
      right_format = "$cmd_duration";
      add_newline = false;
      directory = {
        truncation_length = 4;
        truncate_to_repo = false;
        style = "blue";
        before_repo_root_style = "blue";
        repo_root_style = "bold bright-blue";
        truncation_symbol = "…/";
      };
      time = {
        disabled = true;
        format = "\\[$time\\]($style)";
      };
      cmd_duration = { format = "[$duration]($style)"; };
      git_branch = {
        symbol = "";
        style = "green";
        format = "[$symbol$branch(:$remote_branch)]($style)";
      };
      nix_shell = {
        symbol = " ";
        style = "cyan";
        format = "[$symbol$state(\\($name\\))]($style)";
      };
      kubernetes = {
        disabled = false;
        symbol = "⚓";
        format = "[$symbol$context(\\($namespace\\))]($style)";
        style = "purple";
      };
      #      custom.kswitch = {
      #        command = "kubectl config current-context ";
      #        when = ''test $(kswitch --json | jq -e -r '. | select(.tunnel.status == "up") | select(.context == .tunnel.zone) | .context') = $(kubectl config current-context)'';
      #        style = "purple";
      #        format = "[ ⚓K/$output]($style) ";
      #      };
      #      custom.rswitch = {
      #        command = "kubectl config current-context | sed -e 's/^rswitch-//'";
      #        when = "kubectl config current-context | grep -q ^rswitch-";
      #        style = "purple";
      #        format = "[ ⚓R/$output]($style) ";
      #      };
    };
  };
}
