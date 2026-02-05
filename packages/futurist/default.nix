{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  debtcollector,
  pbr,
  eventlet,
  coverage,
  oslotest,
  stestr,
  testscenarios,
  testtools,
  prettytable,
}:

buildPythonPackage (finalAttrs: {
  pname = "futurist";
  version = "3.2.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "futurist";
    tag = finalAttrs.version;
    hash = "sha256-IrISdaVykQsRnfPk9bu1FpYtbyvMxzWm39FLpQmrFAM=";
  };

  env.PBR_VERSION = finalAttrs.version;

  build-system = [
    pbr
  ];

  dependencies = [ debtcollector ];

  pythonImportsCheck = [ "futurist" ];

  checkPhase = ''
    runHook preCheck

    stestr run

    runHook postCheck
  '';

  nativeCheckInputs = [
    eventlet
    coverage
    oslotest
    stestr
    testscenarios
    testtools
    prettytable
  ];

  meta = {
    description = "Collection of async functionality and additions from the future";
    homepage = "https://docs.openstack.org/futurist/";
    downloadPage = "https://github.com/openstack/futurist/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    maintainers = lib.teams.openstack.members;
  };
})
