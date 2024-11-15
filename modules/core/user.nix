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
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
  };

  programs.fish.enable = true;
  users.users."${username}" = {
    uid = 502;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    isSystemUser = true;
    group = "users";
    createHome = true;
    home = "/home/${username}";
    homeMode = "700";
    shell = pkgs.fish;
  };

  nix.settings.allowed-users = [ "${username}" ];
}
