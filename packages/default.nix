{ pkgs, self' }:

let
  # Discover all package directories
  allEntries = builtins.readDir ./.;

  # Filter to only directories (exclude default.nix, lib.nix, etc.)
  packageNames = builtins.filter (name: allEntries.${name} == "directory") (
    builtins.attrNames allEntries
  );

  # Create overlay with all discovered packages
  pythonPackagesExtensions =
    self: super:
    builtins.listToAttrs (
      map (name: {
        inherit name;
        value = self.callPackage (./${name}) { };
      }) packageNames
    );

  python = pkgs.python3.override {
    packageOverrides = pythonPackagesExtensions;
  };

  # Export all packages
  exportedPackages = builtins.listToAttrs (
    map (name: {
      inherit name;
      value = python.pkgs.${name};
    }) packageNames
  );
in
exportedPackages
