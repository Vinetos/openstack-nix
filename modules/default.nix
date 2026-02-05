{ lib, ... }:

{
  imports = [
    ./services/common.nix
    ./services/keystone.nix
  ];
}
