{ pkgs, username, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_cursor_default line
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  xdg.configFile."starship.toml".source = ./starship.toml;

}
