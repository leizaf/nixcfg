{
  pkgs,
  username,
  home-manager,
  ...
}:
{
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit username;
    };
    users.${username} = {
      imports = [ ./../home ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "25.05";
      programs.home-manager.enable = true;
    };
  };

  programs.fish.enable = true;
  users.users."${username}" = {
    uid = 1000;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    group = "users";
    createHome = true;
    home = "/home/${username}";
    homeMode = "700";
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF22EHMdCWj35l+BkaF7jGzhjUgZiLCAC2g5L1+DcK+3"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDlr90BzWRKNa1lGple7f5wFspr0va0QnwxklwEmUatz"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICOtExqljfO0HBzCCv4BoIxHaKE/dR907fWfnOSxbAwC"
    ];
  };

  nix.settings.allowed-users = [ "${username}" ];
}
