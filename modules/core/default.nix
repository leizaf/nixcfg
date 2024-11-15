{ pkgs, ... }: {
  imports = [ ./user.nix ./nh.nix ];

  environment.systemPackages = with pkgs; [ git lazygit devenv ];

  programs.nix-ld.enable = true;
}
