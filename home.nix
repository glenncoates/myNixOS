{ config, lib, pkgs, home-manager, ... }:

{
  # use system-level nixpkgs rather than the HM private ones
  # "This saves an extra Nixpkgs evaluation, adds consistency, and removes the dependency on NIX_PATH, which is otherwise used for importing Nixpkgs."
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.user = { pkgs, ... }: {
    home.username = "user";
    home.homeDirectory = "/home/user";
    programs.home-manager.enable = true;
    home.packages = with pkgs;
      [
        # your desired nixpkgs here
        nomachine-client
      ];
    home.stateVersion = "23.05";
  };
}
