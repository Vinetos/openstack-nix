# Packages

This directory contains all packages that are not yet available in nixpkgs.

# How to add a package

1. Create the corresponding folder
2. Nixifies the package
3. Add it to `packages/default.nix`
4. Test the build with `nix build .#my-package`
5. Create a MR !
