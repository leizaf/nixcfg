{ pkgs, ... }:
let
  packages = import ./packages.nix;
  helix = import ./helix.nix;
  vscode = import ./vscode.nix;
in
{
  fonts.fontconfig.enable = true;

  home.packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  imports = [
    packages
    helix
    vscode
  ];
}
