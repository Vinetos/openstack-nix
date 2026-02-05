{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,

  # direct
  setproctitle,
  typing-extensions,

  # tests
  mock,
  pytestCheckHook,
  pytest-xdist,
  oslo-config,
}:

buildPythonPackage (finalAttrs: {
  pname = "cotyledon";
  version = "2.2.0";
  pyproject = true;

  build-system = [
    setuptools
    setuptools-scm
  ];

  env.PBR_VERSION = finalAttrs.version;

  src = fetchFromGitHub {
    owner = "sileht";
    repo = "cotyledon";
    tag = finalAttrs.version;
    hash = "sha256-PILhNATf+FbWUaFMUZvUwe27QEczYY8sbwasvP5s05M=";
  };

  dependencies = [
    setproctitle
    typing-extensions
  ];

  nativeCheckInputs = [
    mock
    pytestCheckHook
    pytest-xdist
    oslo-config
  ];

  # See https://github.com/NixOS/nixpkgs/issues/255262
  pytestFlags = [
    "--import-mode=importlib"
  ];

  pythonImportsCheck = [ "cotyledon" ];

  meta = {
    description = "Framework for defining long-running services";
    homepage = "https://github.com/sileht/cotyledon";
    downloadPage = "https://github.com/sileht/cotyledon/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
})
