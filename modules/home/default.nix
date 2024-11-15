{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = [ (pkgs.nerdfonts.override { fonts = [ "GeistMono" ]; }) ];

  imports = [
    ./shell
    ./helix.nix
    ./git.nix
  ];
}
