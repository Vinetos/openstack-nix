{ lib, config, ... }:

with lib;

{
  options.services.openstack.common = {

    region = mkOption {
      type = types.str;
      default = "RegionOne";
      description = "OpenStack region name";
    };

    adminPass = mkOption {
      type = types.str;
      description = "Password for an administrative user";
    };
  };
}
