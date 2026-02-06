{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pbr,
  setuptools,

  # direct
  webob,
  flask,
  flask-restful,
  cryptography,
  sqlalchemy,
  stevedore,
  python-keystoneclient,
  keystonemiddleware,
  bcrypt,
  oslo-cache,
  oslo-config,
  oslo-context,
  oslo-messaging,
  oslo-db,
  oslo-i18n,
  oslo-log,
  oslo-middleware,
  oslo-policy,
  oslo-serialization,
  oslo-upgradecheck,
  oslo-utils,
  oauthlib,
  pysaml2,
  pyjwt,
  dogpile-cache,
  jsonschema,
  pycadf,
  msgpack,
  osprofiler,
  werkzeug,

  # tests
  hacking,
  stestr,
  freezegun,
  coverage,
  fixtures,
  lxml,
  oslotest,
  webtest,
  testtools,
  requests,
  bandit,
  python-ldap,
}:

buildPythonPackage (finalAttrs: {
  pname = "keystone";
  version = "28.0.0";
  pyproject = true;

  build-system = [
    pbr
    setuptools
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "keystone";
    rev = "7b5702f994139140ce195acbe15598dfcf4c8b98";
    hash = "sha256-Btov3/Olm1kAXBCxCl8RFr45pBmyFU2zOQILPOFbZj4=";
  };

  dependencies = [
    webob
    flask
    flask-restful
    cryptography
    sqlalchemy
    stevedore
    python-keystoneclient
    keystonemiddleware
    bcrypt
    oslo-cache
    oslo-config
    oslo-context
    oslo-messaging
    oslo-db
    oslo-i18n
    oslo-log
    oslo-middleware
    oslo-policy
    oslo-serialization
    oslo-upgradecheck
    oslo-utils
    oauthlib
    pysaml2
    pyjwt
    dogpile-cache
    jsonschema
    pycadf
    msgpack
    osprofiler
    werkzeug
  ];

  nativeCheckInputs = [
    hacking
    stestr
    freezegun
    oslo-db
    coverage
    fixtures
    lxml
    oslotest
    webtest
    testtools
    requests
    bandit
    python-ldap
  ];

  checkPhase = ''
    runHook preCheck

    stestr run

    runHook postCheck
  '';

  pythonImportsCheck = [
    "keystone"
  ];

  meta = {
    description = "OpenStack Keystone service";
    homepage = "https://docs.openstack.org/keystone/latest/";
    downloadPage = "https://github.com/openstack/keystone/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
