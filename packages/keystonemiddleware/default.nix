{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pbr,
  setuptools,

  # direct
  keystoneauth1,
  oslo-cache,
  oslo-config,
  oslo-context,
  oslo-i18n,
  oslo-log,
  oslo-serialization,
  oslo-utils,
  pycadf,
  pyjwt,
  python-keystoneclient,
  requests,
  webob,

  # tests
  hacking,
  coverage,
  cryptography,
  fixtures,
  oslotest,
  stevedore,
  requests-mock,
  stestr,
  testresources,
  testtools,
  python-binary-memcached,
  python-memcached,
  webtest,
  oslo-messaging,
}:

buildPythonPackage (finalAttrs: {
  pname = "keystonemiddleware";
  version = "11.0.0";
  pyproject = true;

  build-system = [
    pbr
    setuptools
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "keystonemiddleware";
    tag = finalAttrs.version;
    hash = "sha256-E+Oh3EupZbmo8pmOVZZiN+iLT3idJ4cCn72aTYZ5nak=";
  };

  dependencies = [
    keystoneauth1
    oslo-cache
    oslo-config
    oslo-context
    oslo-i18n
    oslo-log
    oslo-serialization
    oslo-utils
    pycadf
    pyjwt
    python-keystoneclient
    requests
    webob
  ];

  nativeCheckInputs = [
    hacking
    coverage
    cryptography
    fixtures
    oslotest
    stevedore
    requests-mock
    stestr
    testresources
    testtools
    python-binary-memcached
    python-memcached
    webtest
    oslo-messaging
    pyjwt
  ];

  checkPhase = ''
    runHook preCheck

    stestr run

    runHook postCheck
  '';

  pythonImportsCheck = [
    "keystonemiddleware"
    "keystonemiddleware._common"
    "keystonemiddleware.audit"
    "keystonemiddleware.auth_token"
    "keystonemiddleware.echo"
  ];

  meta = {
    description = "Keystone middleware modules designed to provide authentication and authorization features to web services";
    homepage = "https://docs.openstack.org/keystonemiddleware/latest/";
    downloadPage = "https://github.com/openstack/keystonemiddleware/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
