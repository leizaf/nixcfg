{ pkgs, username, home-manager, ... }: {
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit username; };
    users.${username} = {
      imports = [ ./../home ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
  };

  nix.settings.allowed-users = [ "${username}" ];
}
