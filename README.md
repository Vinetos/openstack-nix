# Openstack Nix

Openstack-nix aims to configure openstack composants and services using Nix.

This project is a work in progress and, if you are brave enough, ready for production.

# How to setup a server

Import the modules in your flake.nix:

```nix
inputs = {
  openstack-nix.url = "github:Vinetos/openstack-nix";
};
```

Import the module on your system:

```nix
imports = [
  inputs.openstack-nix.nixosModules.default
];
```

Do some configuration:

```nix
# Setup a database
services.mysql = {
  enable = true;
  package = pkgs.mariadb;
  ensureUsers = [
    {
      # replace with your unix user
      name = "vinetos";
      ensurePermissions = {
        "*.*" = "ALL PRIVILEGES";
      };
    }
  ];
};

services.openstack = {
  common.adminPass = "ADMIN_PASS";
  keystone = {
    enable = true;
    database.password = "MyVeryStongKeystonePass";
    extraSettings = {
      DEFAULT = {
        debug = true;
        use_stderr = true;
      };
    };
  };
};
```

That's it ?!
