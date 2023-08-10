{
   description = "Glenns NixOS";

  # the source of your packages
  inputs = 
  {
    # normal nix stuff
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    flake-utils.url = "github:/numtide/flake-utils";

    # home-manager stuff
    home-manager.url = "github:nix-community/home-manager/release-23.05";

    # use the version of nixpkgs we specified above rather than the one HM would ordinarily use
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };


  # what will be produced (i.e. the build)
  # Could alternativery say, outputs = inputs
  outputs = { self, nixpkgs, flake-utils, home-manager }: 
  {
      # define a "nixos" build
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
      {
        # system to build for
        system = "x86_64-linux";

        #config.allowUnfree = true;
        #

        specialArgs = { inherit home-manager; };

        # modules to use
        modules = 
        [
          ./configuration.nix # our previous config file
        ];
      };
  };
}

