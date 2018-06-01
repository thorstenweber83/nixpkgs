{stdenv, fetchurl, hdf5_1_8, gfortran, python27}:
stdenv.mkDerivation rec{
  name = "libmed-${version}";
  version = "3.3.1";
  src = fetchurl {
    url = "http://files.salome-platform.org/Salome/other/med-${version}.tar.gz";
    sha256 = "1215sal10xp6xirgggdszay2bmx0sxhn9pgh7x0wg2w32gw1wqyx";
  };

  buildInputs = [hdf5_1_8 gfortran python27];

  configureFlags = ["--with-hdf5=${hdf5_1_8}"];
}
