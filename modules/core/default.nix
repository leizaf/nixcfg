{...}:
let
  op = import ./1password.nix;
  user = import ./user.nix;
  wayland = import ./wayland.nix;
in
{
  imports = [
    op
    user
    wayland
  ];

  programs.nix-ld.enable = true;
}
