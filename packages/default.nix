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
    )
    // {
      # pysaml2 (keystone deps), is not compatible with latest xmlschema versions
      # So we override to an old compatible version
      # https://github.com/IdentityPython/pysaml2/issues/947
      xmlschema = super.xmlschema.overridePythonAttrs (old: rec {
        version = "4.1.0";
        src = pkgs.fetchPypi {
          pname = "xmlschema";
          inherit version;
          hash = "sha256-iKx3HPlNX8a70adj24wVfz1oOtIxILDQuMRv5FN/Kt8=";
        };
      });
    };

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
