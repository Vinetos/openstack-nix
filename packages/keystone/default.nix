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
  stestrCheckHook,
  versionCheckHook,
  hacking,
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
  ldappool,
  which,
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

  patches = [
    ./fix-pyproject.patch
  ];

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
    oslo-db.optional-dependencies.mysql
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
  ] ++ lib.concatAttrValues finalAttrs.passthru.optional-dependencies;

  nativeCheckInputs = [
    stestrCheckHook
    hacking
    freezegun
    oslo-db
    oslo-policy
    coverage
    fixtures
    lxml
    oslotest
    webtest
    testtools
    requests
    bandit
    python-ldap
    ldappool
    which
  ];

  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgram = "${placeholder "out"}/bin/keystone-manage";
  doInstallCheck = true;

  pythonImportsCheck = [
    "keystone"
    "keystone.api"
    "keystone.application_credential"
    "keystone.assignment"
    "keystone.auth"
    "keystone.catalog"
    "keystone.cmd"
    "keystone.common"
    "keystone.conf"
    "keystone.credential"
    "keystone.endpoint_policy"
    "keystone.federation"
    "keystone.identity"
    "keystone.limit"
    "keystone.models"
    "keystone.oauth1"
    "keystone.oauth2"
    "keystone.policy"
    "keystone.receipt"
    "keystone.resource"
    "keystone.revoke"
    "keystone.server"
    "keystone.tests"
    "keystone.token"
    "keystone.trust"
    "keystone.wsgi"
  ];

  meta = {
    description = "OpenStack Keystone service";
    homepage = "https://docs.openstack.org/keystone/latest/";
    downloadPage = "https://github.com/openstack/keystone/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
