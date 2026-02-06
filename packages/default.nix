{ pkgs, self' }:

let
  # Add my custom python package to global python for easier use
  pythonPackagesExtensions = self: super: {
    cotyledon = self.callPackage ./cotyledon { };
    futurist = self.callPackage ./futurist { };
    keystonemiddleware = self.callPackage ./keystonemiddleware { };
    oslo-cache = self.callPackage ./oslo-cache { };
    oslo-messaging = self.callPackage ./oslo-messaging { };
    oslo-middleware = self.callPackage ./oslo-middleware { };
    oslo-service = self.callPackage ./oslo-service { };
    pycadf = self.callPackage ./pycadf {};
    python-binary-memcached = self.callPackage ./python-binary-memcached { };
  };

  python = pkgs.python3.override {
    packageOverrides = pythonPackagesExtensions;
  };
in
{
  cotyledon = python.pkgs.cotyledon;
  futurist = python.pkgs.futurist;
  keystonemiddleware = python.pkgs.keystonemiddleware;
  oslo-cache = python.pkgs.oslo-cache;
  oslo-messaging = python.pkgs.oslo-messaging;
  oslo-middleware = python.pkgs.oslo-middleware;
  oslo-service = python.pkgs.oslo-service;
  pycadf = python.pkgs.pycadf;
  python-binary-memcached = python.pkgs.python-binary-memcached;
}
