{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pbr,
  setuptools,

  # direct
  requests,
  oslo-config,
  oslo-context,
  oslo-i18n,
  oslo-serialization,
  pyyaml,
  stevedore,
  oslo-utils,

  # tests
  oslotest,
  requests-mock,
  stestr,
  sphinx,
  coverage,
}:

buildPythonPackage (finalAttrs: {
  pname = "oslo-policy";
  version = "4.8.0";
  pyproject = true;

  build-system = [
    pbr
    setuptools
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "oslo.policy";
    tag = finalAttrs.version;
    hash = "sha256-GnGsye4gXsUymTBi4SDo3v/YtzPEOQtvM80Tnn8YUGk=";
  };

  dependencies = [
    requests
    oslo-config
    oslo-context
    oslo-i18n
    oslo-serialization
    pyyaml
    stevedore
    oslo-utils
  ];

  nativeCheckInputs = [
    oslotest
    requests-mock
    stestr
    sphinx
    coverage
  ];

  checkPhase = ''
    runHook preCheck

    stestr run

    runHook postCheck
  '';

  pythonImportsCheck = [
    "oslo_policy"
  ];

  meta = {
    description = "Oslo policy library";
    homepage = "https://docs.openstack.org/oslo.policy/";
    downloadPage = "https://github.com/openstack/oslo.policy/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
