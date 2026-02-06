{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pbr,
  setuptools,

  # direct
  futurist,
  oslo-config,
  oslo-context,
  oslo-log,
  oslo-utils,
  oslo-serialization,
  oslo-service,
  stevedore,
  debtcollector,
  cachetools,
  webob,
  pyyaml,
  amqp,
  kombu,
  oslo-middleware,
  oslo-metrics,

  # tests
  fixtures,
  stestr,
  testscenarios,
  testtools,
  oslotest,
  pifpaf,
  confluent-kafka,
  coverage,
  eventlet,
  greenlet,
}:

buildPythonPackage (finalAttrs: {
  pname = "oslo-messaging";
  version = "17.2.0";
  pyproject = true;

  build-system = [
    pbr
    setuptools
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "oslo.messaging";
    tag = finalAttrs.version;
    hash = "sha256-XOEWApNIZ+L10A3ZA5QxfLiEmoxzER+Xh5L3OUyViQk=";
  };

  patches = [
    ./fix-pyproject.patch
  ];

  dependencies = [
    futurist
    oslo-config
    oslo-context
    oslo-log
    oslo-utils
    oslo-serialization
    oslo-service
    stevedore
    debtcollector
    cachetools
    webob
    pyyaml
    amqp
    kombu
    oslo-middleware
    oslo-metrics
  ];

  nativeCheckInputs = [
    fixtures
    stestr
    testscenarios
    testtools
    oslotest
    pifpaf
    confluent-kafka
    coverage
    eventlet
    greenlet
  ];

  checkPhase = ''
    runHook preCheck

    stestr run

    runHook postCheck
  '';

  pythonImportsCheck = [
    "oslo_messaging"
    "oslo_messaging._drivers"
    "oslo_messaging._metrics"
    "oslo_messaging.hacking"
    "oslo_messaging.notify"
    "oslo_messaging.rpc"
  ];

  meta = {
    description = "Oslo messaging library";
    homepage = "https://docs.openstack.org/oslo.messaging/";
    downloadPage = "https://github.com/openstack/oslo.messaging/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
