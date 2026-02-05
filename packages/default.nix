{ pkgs, self' }:

let
  # Add my custom python package to global python for easier use
  pythonPackagesExtensions = self: super: {
    futurist = self.callPackage ./futurist { };
    oslo-cache = self.callPackage ./oslo-cache { };
    oslo-messaging = self.callPackage ./oslo-messaging { };
    python-binary-memcached = self.callPackage ./python-binary-memcached { };
    keystonemiddleware = self.callPackage ./keystonemiddleware { };
  };

  python = pkgs.python3.override {
    packageOverrides = pythonPackagesExtensions;
  };
in
{
  futurist = python.pkgs.futurist;
  oslo-cache = python.pkgs.oslo-cache;
  oslo-messaging = python.pkgs.oslo-messaging;
  python-binary-memcached = python.pkgs.python-binary-memcached;
  keystonemiddleware = python.pkgs.keystonemiddleware;
}
