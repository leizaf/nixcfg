{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = [ pkgs.nerd-fonts.geist-mono ];

  imports = [
    ./shell
    ./helix.nix
    ./git.nix
  ];
}
