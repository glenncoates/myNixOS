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

        # modules to use
        modules = 
        [
          ./configuration.nix # our previous config file
          ./packages.nix
          ./doc.nix
          home-manager.nixosModules.home-manager # make home manager available to configuration.nix
          {
            # use system-level nixpkgs rather than the HM private ones
            # "This saves an extra Nixpkgs evaluation, adds consistency, and removes the dependency on NIX_PATH, which is otherwise used for importing Nixpkgs."
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.glenn = { pkgs, ... }: 
            {
              home.username = "glenn";
              home.homeDirectory = "/home/glenn";
              programs.home-manager.enable = true;
              home.packages = with pkgs; 
              [
                # your desired nixpkgs here
                nomachine-client
              ];
              home.stateVersion = "23.05";
           };
          }
        ];
      };
  };
}

