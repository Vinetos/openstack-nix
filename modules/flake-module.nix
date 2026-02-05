{ self, ... }:

{
  flake.nixosModules = {
    # Default expose all modules
    default = ./default.nix;

    # Individual services
    keystone = ./services/keystone.nix;

    # Profiles
    all-in-one = ./profiles/all-in-one.nix;
  };
}
