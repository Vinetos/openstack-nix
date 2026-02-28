{ lib, flake-parts-lib, moduleWithSystem, ... }:
let
  inherit (flake-parts-lib) importApply;
in
{
  flake.nixosModules = {
    # Default expose all modules
    default = ./default.nix;

    # Individual services
    keystone = ./services/keystone.nix;

    # Profiles
    all-in-one = importApply ./profiles/all-in-one.nix { inherit lib moduleWithSystem; };
  };
}
