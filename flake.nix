{
	description = "Hyprland on NixOS";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
    musnix.url = "github:musnix/musnix";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, musnix, ... }: {
		nixosConfigurations.Alpha = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
        musnix.nixosModules.musnix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.izaird = import ./home.nix;
						backupFileExtension = "backup";

					};

				}
			];
		};
	};

}
