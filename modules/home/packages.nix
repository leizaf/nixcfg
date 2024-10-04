{ pkgs, ... }:
{
  home.packages = (
    with pkgs;
    [
      brave
      discord
      lazygit
      nixfmt-rfc-style
      cachix
      git
      nh
      google-chrome
      zed-editor
    ]
  );
}
