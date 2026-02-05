{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pbr,
  setuptools,

  # direct
  webob,
  debtcollector,
  eventlet,
  greenlet,
  oslo-utils,
  oslo-concurrency,
  oslo-config,
  oslo-log,
  oslo-i18n,
  pastedeploy,
  routes,
  paste,
  yappi,

  # tests
  fixtures,
  oslotest,
  requests,
  stestr,
  coverage,
  cotyledon,
  futurist,
  ps,
}:

buildPythonPackage (finalAttrs: {
  pname = "oslo-service";
  version = "4.4.1";
  pyproject = true;

  build-system = [
    pbr
    setuptools
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "oslo.service";
    tag = finalAttrs.version;
    hash = "sha256-F3wwiHsTT4Ps+vcqlonPkFIYG2FrCCd211Pykh/X6Ao=";
  };

  postPatch = ''
    # TODO: somehow bring this to upstreams attention
    substituteInPlace pyproject.toml \
      --replace-fail '"oslo_service"' '"oslo_service", "oslo_service.backend", "oslo_service.backend._common", "oslo_service.backend._eventlet", "oslo_service.backend._threading"'
  '';

  optional-dependencies = {
    threading = [
      cotyledon
      futurist
    ];
  };

  dependencies = [
    webob
    debtcollector
    eventlet
    greenlet
    oslo-utils
    oslo-concurrency
    oslo-config
    oslo-log
    oslo-i18n
    pastedeploy
    routes
    paste
    yappi
  ];

  nativeCheckInputs = [
    fixtures
    oslotest
    requests
    stestr
    coverage
    cotyledon
    futurist
    ps
  ]
  ++ lib.concatAttrValues finalAttrs.passthru.optional-dependencies;

  checkPhase = ''
    runHook preCheck

    stestr run

    runHook postCheck
  '';

  pythonImportsCheck = [
    "oslo_service"
    "oslo_service.backend"
    "oslo_service.backend._common"
    "oslo_service.backend._eventlet"
    "oslo_service.backend._threading"
  ];

  meta = {
    description = "Oslo service library";
    homepage = "https://docs.openstack.org/oslo.service/";
    downloadPage = "https://github.com/openstack/oslo.service/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
