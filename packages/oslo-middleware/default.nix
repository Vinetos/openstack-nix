{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pbr,
  setuptools,

  # direct
  bcrypt,
  jinja2,
  oslo-config,
  oslo-context,
  oslo-i18n,
  oslo-utils,
  statsd,
  stevedore,
  typing-extensions,
  webob,

  # tests
  fixtures,
  oslotest,
  testtools,
  coverage,
  oslo-serialization,
  stestr,

}:

buildPythonPackage (finalAttrs: {
  pname = "oslo-middleware";
  version = "7.0.0";
  pyproject = true;

  build-system = [
    pbr
    setuptools
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "oslo.middleware";
    tag = finalAttrs.version;
    hash = "sha256-HflwhXOXsHwKCtytcc0Hb4Q040mxiD1m7r4NyPCrjOo=";
  };

  postPatch = ''
    # TODO: somehow bring this to upstreams attention
    substituteInPlace pyproject.toml \
      --replace-fail '"oslo_middleware"' '"oslo_middleware", "oslo_middleware.healthcheck"'
  '';

  dependencies = [
    bcrypt
    jinja2
    oslo-config
    oslo-context
    oslo-i18n
    oslo-utils
    statsd
    stevedore
    typing-extensions
    webob
  ];

  nativeCheckInputs = [
    fixtures
    oslotest
    testtools
    coverage
    oslo-serialization
    stestr
  ];

  checkPhase = ''
    runHook preCheck

    stestr run

    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_middleware" ];

  meta = {
    description = "Oslo middleware library";
    homepage = "https://docs.openstack.org/oslo.middleware/";
    downloadPage = "https://github.com/openstack/oslo.middleware/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
