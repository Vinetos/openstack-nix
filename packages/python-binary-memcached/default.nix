{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  uhashring,
  flake8,
  mock,
  pytest,
  pytest-cov,
  six,
  trustme,
}:

buildPythonPackage (finalAttrs: {
  pname = "python-binary-memcached";
  version = "0.31.4";
  pyproject = true;

  build-system = [ setuptools ];

  # fetchPypi because latest release is not tagged on Github.
  # NOTE(vinetos): We night use commit hash instead
  src = fetchPypi {
    pname = "python_binary_memcached";
    version = "${finalAttrs.version}";
    hash = "sha256-8YO8Z/0hjAHrwL9OmSmiEN1aoH/aU9W2J9C0Q7duKBg=";
  };

  propagatedBuildInputs = [
    six
    uhashring
  ];

  checkInputs = [
    flake8
    mock
    pytest
    pytest-cov
    trustme
  ];
})
