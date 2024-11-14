{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, nixos-cosmic, ... }@inputs:
    let
      username = "lfu";
      overlays = { nixpkgs.overlays = [ inputs.helix.overlays.default ]; };
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [ overlays ./hosts/desktop nixos-cosmic.nixosModules.default ];
          specialArgs = {
            host = "desktop";
            inherit self inputs username;
          };
        };

        orb = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ overlays ./common.nix ./hosts/orb ];
          specialArgs = {
            host = "orb";
            inherit self inputs username;
          };
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
      formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixfmt;
    };
}
