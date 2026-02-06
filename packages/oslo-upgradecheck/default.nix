{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pbr,
  setuptools,

  # direct
  oslo-config,
  oslo-i18n,
  prettytable,
  oslo-utils,
  oslo-policy,

  # tests
  oslotest,
  stestr,
  oslo-serialization,
}:

buildPythonPackage (finalAttrs: {
  pname = "oslo-upgradecheck";
  version = "2.7.0";
  pyproject = true;

  build-system = [
    pbr
    setuptools
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "oslo.upgradecheck";
    tag = finalAttrs.version;
    hash = "sha256-UNgf+/qidVjES6ufmG7NtXUdVyaNMwezzX2J691ynJA=";
  };

  dependencies = [
    oslo-config
    oslo-i18n
    prettytable
    oslo-utils
    oslo-policy
  ];

  nativeCheckInputs = [
    oslotest
    stestr
    oslo-serialization
  ];

  checkPhase = ''
    runHook preCheck

    stestr run

    runHook postCheck
  '';

  pythonImportsCheck = [
    "oslo_upgradecheck"
  ];

  meta = {
    description = "Oslo upgradecheck library";
    homepage = "https://docs.openstack.org/oslo.upgradecheck/";
    downloadPage = "https://github.com/openstack/oslo.upgradecheck/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
