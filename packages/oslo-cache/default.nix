{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pbr,
  setuptools,

  # direct
  dogpile-cache,
  oslo-config,
  oslo-i18n,
  oslo-log,
  oslo-utils,

  # tests
  oslotest,
  pifpaf,
  stestr,
  pymemcache,
  python-binary-memcached,
  python-memcached,
  etcd3,
  redis,
}:

buildPythonPackage (finalAttrs: {
  pname = "oslo-cache";
  version = "4.0.0";
  pyproject = true;

  build-system = [
    pbr
    setuptools
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "oslo.cache";
    tag = finalAttrs.version;
    hash = "sha256-MfNhQxiDuTLxGmfOzm7rPQd5+CZw5/EgP8k0MVehUGY=";
  };

  dependencies = [
    dogpile-cache
    oslo-config
    oslo-i18n
    oslo-log
    oslo-utils
  ];

  nativeCheckInputs = [
    oslotest
    stestr
    pifpaf
    pymemcache
    python-binary-memcached
    python-memcached
    etcd3
    redis
  ];

  checkPhase = ''
    runHook preCheck

    stestr run

    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_cache" ];

  meta = {
    description = "Oslo cache library";
    homepage = "https://docs.openstack.org/oslo.cache";
    downloadPage = "https://github.com/openstack/oslo.cache/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
