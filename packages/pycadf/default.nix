{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pbr,
  setuptools,

  # direct
  oslo-config,
  oslo-serialization,

  # tests
  coverage,
  fixtures,
  stestr,
  testtools,
}:

buildPythonPackage (finalAttrs: {
  pname = "pycadf";
  version = "4.0.1";
  pyproject = true;

  build-system = [
    pbr
    setuptools
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "pycadf";
    rev = "4a33208bbeed6f790bab0e63539c3e64e37001a9";
    hash = "sha256-665iAfa9yOrLY01c7rJJhyyEwteaTXUfmmR3BDSNvsg=";
  };

  patches = [
    ./fix-pyproject.patch
  ];

  dependencies = [
    oslo-config
    oslo-serialization
  ];

  nativeCheckInputs = [
    fixtures
    stestr
    testtools
    coverage
  ];

  checkPhase = ''
    runHook preCheck

    stestr run

    runHook postCheck
  '';

  pythonImportsCheck = [
    "pycadf"
    "pycadf.helper"
  ];

  meta = {
    description = "OpenStack auditing data model library";
    homepage = "https://docs.openstack.org/pycadf/";
    downloadPage = "https://github.com/openstack/pycadf/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
