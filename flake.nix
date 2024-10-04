{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-cosmic,
      ...
    }@inputs:
    let
      username = "lfu";
      sharedModules = [
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.config.cudaSupport = true;
          nix.settings = {
            trusted-users = [
              "root"
              "lfu"
            ];
            experimental-features = [
              "fetch-closure"
              "flakes"
              "nix-command"
            ];
            substituters = [
              "https://cache.nixos.org"
              "https://nix-community.cachix.org"
              "https://cosmic.cachix.org/"
            ];
            trusted-public-keys = [
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
              "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
            ];
          };
        }
        nixos-cosmic.nixosModules.default
      ];
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (import ./hosts/desktop) ] ++ sharedModules;
          specialArgs = {
            host = "desktop";
            inherit self inputs username;
          };
        };
      };
    };
}
