{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pbr,
  setuptools,

  # direct
  alembic,
  debtcollector,
  oslo-i18n,
  oslo-config,
  oslo-utils,
  sqlalchemy,
  stevedore,
  testresources,
  testscenarios,

  # tests
  coverage,
  fixtures,
  oslotest,
  oslo-context,
  stestrCheckHook,
  testtools,
  pifpaf,
  aiosqlite,
  pymysql,
  psycopg2,
  which,
}:

buildPythonPackage (finalAttrs: {
  pname = "oslo-db";
  version = "18.0.0";
  pyproject = true;

  build-system = [
    pbr
    setuptools
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "oslo.db";
    tag = finalAttrs.version;
    hash = "sha256-VnHJ0sAF8HjHy54WwkAFaCMwgya7vNhXWpS2jyQDBRE=";
  };

  patches = [
    ./fix-pyproject.patch
  ];

  dependencies = [
    alembic
    debtcollector
    oslo-i18n
    oslo-config
    oslo-utils
    sqlalchemy
    stevedore
    testresources
    testscenarios
  ];

  optional-dependencies = {
    mysql = [
      pymysql
    ];
    postgresql = [ psycopg2 ];
  };

  nativeCheckInputs = [
    stestrCheckHook
    coverage
    fixtures
    oslotest
    oslo-context
    testtools
    pifpaf
    aiosqlite
    which
  ]
  ++ lib.concatAttrValues finalAttrs.passthru.optional-dependencies;

  pythonImportsCheck = [
    "oslo_db"
    "oslo_db.sqlalchemy"
    "oslo_db.sqlalchemy.migration_cli"
    "oslo_db.tests"
    "oslo_db.tests.sqlalchemy"
  ];

  meta = {
    description = "Oslo Database library";
    homepage = "https://docs.openstack.org/oslo.db";
    downloadPage = "https://github.com/openstack/oslo.db/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
