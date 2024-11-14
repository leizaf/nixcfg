{ pkgs, ... }: {
  imports = [ ./user.nix ./nh.nix ];

  environment.systemPackages = with pkgs; [ git lazygit ];

  programs.nix-ld.enable = true;
}
