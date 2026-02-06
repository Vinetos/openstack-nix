{ pkgs, self' }:

let
  # Add my custom python package to global python for easier use
  pythonPackagesExtensions = self: super: {
    cotyledon = self.callPackage ./cotyledon { };
    futurist = self.callPackage ./futurist { };
    oslo-cache = self.callPackage ./oslo-cache { };
    oslo-messaging = self.callPackage ./oslo-messaging { };
    oslo-middleware = self.callPackage ./oslo-middleware { };
    oslo-service = self.callPackage ./oslo-service { };
    pycadf = self.callPackage ./pycadf {};
    python-binary-memcached = self.callPackage ./python-binary-memcached { };
    keystonemiddleware = self.callPackage ./keystonemiddleware { };
  };

  python = pkgs.python3.override {
    packageOverrides = pythonPackagesExtensions;
  };
in
{
  cotyledon = python.pkgs.cotyledon;
  futurist = python.pkgs.futurist;
  oslo-cache = python.pkgs.oslo-cache;
  oslo-messaging = python.pkgs.oslo-messaging;
  oslo-middleware = python.pkgs.oslo-middleware;
  oslo-service = python.pkgs.oslo-service;
  pycadf = python.pkgs.pycadf;
  python-binary-memcached = python.pkgs.python-binary-memcached;
  keystonemiddleware = python.pkgs.keystonemiddleware;
}
