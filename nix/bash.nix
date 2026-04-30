{ pkgs, lib, config, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = ''
      export PATH=$PATH:$HOME/.local/bin
      eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init bash --config $HOME/.cache/oh-my-posh/themes/if_tea.omp.json)"
      ${pkgs.fastfetch}/bin/fastfetch
    '';
    shellAliases = {
      ll = "ls -la";
    };
  };
}
