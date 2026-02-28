{ lib, moduleWithSystem, ... }:

moduleWithSystem (
  perSystem@{ self', pkgs, ... }:
  nixos@{ ... }:
  {
    imports = [
      ../services/common.nix
      ../services/keystone.nix
    ];

    services.openstack = {
      common = {
        adminPass = lib.mkDefault "ADMIN_PASS";
        region = lib.mkDefault "RegionOne";
      };
      keystone = {
        enable = true;
        package = self'.packages.keystone;
        database.password = lib.mkDefault "KEYSTONE_DBPASS";
        extraSettings = {
        };
      };
    };

    # Common configuration for all-in-one deployment
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureUsers = [
        {
          # For debug purpose
          name = "vinetos";
          ensurePermissions = {
            "*.*" = "ALL PRIVILEGES";
          };
        }
      ];
    };
  }
)
