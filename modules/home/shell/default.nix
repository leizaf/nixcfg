{ pkgs, username, ... }:
{
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting ""
    '';
    interactiveShellInit = ''
      set fish_cursor_default line
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  xdg.configFile."starship.toml".source = ./starship.toml;

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
