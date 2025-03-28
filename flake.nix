{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos-cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    let
      username = "lfu";
      overlays = {
        # nixpkgs.overlays = [ inputs.helix.overlays.default ];
      };
    in
    {
      nixosModules = {
        core = ./modules/core;
        orb = ./hosts/orb;
        jetson = ./hosts/jetson;
        wsl = ./hosts/wsl;
      };

      nixosConfigurations = {
        agx-orin = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules =
            [ overlays ]
            ++ (with self.nixosModules; [
              core
              jetson
            ]);
          specialArgs = {
            host = "agx-orin";
            inherit username;
            inherit (inputs) home-manager;
            som = "orin-agx";
          };
        };

        orb = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules =
            [ overlays ]
            ++ (with self.nixosModules; [
              core
              orb
            ]);
          specialArgs = {
            host = "orb";
            inherit username;
            inherit (inputs) home-manager;
          };
        };
        
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [ overlays ]
            ++ (with self.nixosModules; [
              core
              wsl
            ]);
          specialArgs = {
            host = "wsl";
            inherit username;
            inherit (inputs) home-manager;
          };
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        checks = {
          user-exists = pkgs.callPackage ./checks/user-exists.nix {
            inherit username;
            inherit (self) nixosConfigurations;
          };
          fmt = pkgs.callPackage ./checks/fmt.nix { };
        };
        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
