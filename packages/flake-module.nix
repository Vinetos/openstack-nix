{ self, ... }:

{
  perSystem =
    {
      config,
      self',
      inputs',
      pkgs,
      system,
      ...
    }:
    {
      # Expose python package directly
      packages = import ./default.nix {
        inherit pkgs self';
      };
    };
}
