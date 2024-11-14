{ pkgs, ... }:
let helix = import ./helix.nix;
in {
  fonts.fontconfig.enable = true;

  home.packages = [ (pkgs.nerdfonts.override { fonts = [ "GeistMono" ]; }) ];

  imports = [ helix ];
}
