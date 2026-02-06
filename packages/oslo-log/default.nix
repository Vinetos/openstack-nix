{
  lib,
  stdenv,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,

  # dependencies
  debtcollector,
  oslo-config,
  oslo-context,
  oslo-serialization,
  oslo-utils,
  pbr,
  python-dateutil,
  pyinotify,

  # tests
  eventlet,
  oslotest,
  pytestCheckHook,
}:

buildPythonPackage (finalAttrs: {
  # NOTE(vinetos): this package exist outside but it is missing sub-packages
  pname = "oslo-log";
  version = "8.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "oslo.log";
    tag = finalAttrs.version;
    hash = "sha256-XCQc0ByjnXU4/ArgJ6sGgm/EO2DevDdBgma85pjhdSc=";
  };

  # Manually set version because prb wants to get it from the git upstream repository (and we are
  # installing from tarball instead)
  PBR_VERSION = finalAttrs.version;

  build-system = [
    pbr
    setuptools
  ];

  patches = [
    ./fix-pyproject.patch
  ];

  dependencies = [
    debtcollector
    oslo-config
    oslo-context
    oslo-serialization
    oslo-utils
    python-dateutil
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ pyinotify ];

  nativeCheckInputs = [
    eventlet
    oslotest
    pytestCheckHook
  ];

  disabledTests = [
    # not compatible with sandbox
    "test_logging_handle_error"
  ];

  pythonImportsCheck = [
    "oslo_log"
    "oslo_log.cmds"
    "oslo_log.fixture"
  ];

  __darwinAllowLocalNetworking = true;

  meta = {
    description = "Oslo log library";
    homepage = "https://docs.openstack.org/oslo.log";
    downloadPage = "https://github.com/openstack/oslo.log/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
