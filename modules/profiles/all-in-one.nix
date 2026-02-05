{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../services/keystone.nix
  ];

  services.openstack = {
    common.adminPass = lib.mkDefault "ADMIN_PASS";
    keystone = {
      enable = true;
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
