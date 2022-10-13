{
  mkDerivation,
  aeson,
  base,
  bytestring,
  cleff,
  containers,
  data-default,
  fetchgit,
  lib,
  megaparsec,
  optics-core,
  optics-th,
  pandoc-types,
  tasty,
  tasty-hunit,
  text,
  text-builder,
  time,
  transformers,
  vector,
  applyPatches,
  neorg-pandoc-src,
}:
mkDerivation {
  pname = "neorg";
  version = "0.1.0.0";
  src = applyPatches {
    name = "neorg-pandoc-src";
    src = neorg-pandoc-src;
    patches = [./neorg-pandoc.patch];
  };
  isLibrary = true;
  isExecutable = true;

  doCheck = false;

  libraryHaskellDepends = [
    base
    cleff
    containers
    data-default
    megaparsec
    optics-core
    optics-th
    text
    text-builder
    time
    transformers
    vector
  ];
  executableHaskellDepends = [
    aeson
    base
    bytestring
    cleff
    containers
    optics-core
    pandoc-types
    text
    transformers
    vector
  ];
  testHaskellDepends = [
    base
    cleff
    megaparsec
    optics-core
    tasty
    tasty-hunit
    text
    time
    transformers
    vector
  ];
  license = "unknown";
  mainProgram = "neorg-pandoc";
}
