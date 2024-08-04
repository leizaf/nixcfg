{ inputs, pkgs, ... }:
{
  home.packages = (
    with pkgs;
    [
      brave
      lazygit
      nixfmt-rfc-style
      cachix
      git
      nh
      google-chrome
    ]
  );
}
