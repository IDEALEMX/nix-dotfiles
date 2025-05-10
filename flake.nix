{ 
  description = "main flake";

  inputs = {
    # official nixos repo
    nixpkgs.url = "nixpkgs/nixos-24.11";

    # home manager repo
    home-manager.url = "github:nix-community/home-manager/release-24.11";

    # Makes sure home-manager will take on the same version as nixpkgs
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations = {
      ACERNIX5 = lib.nixosSystem {
        inherit system;
	modules = [
	  ./configuration.nix
	];
      };
    };

    homeConfigurations = {
      ideale = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	modules = [
	  ./home.nix
	];
      };
    };

  };
}

# inputs includes list of git repos as input
# output includes the state it causes in the system

