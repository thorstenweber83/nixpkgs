{ buildMaven, fetchFromGitHub, runCommand, writeText, callPackage }:
let
  version = "xmage_1.4.42V6";
  gitSrc = fetchFromGitHub {
    owner = "magefree";
    repo = "mage";
    rev = version;
    sha256 = "068z4pi5bgcsbxdrxrd9cgc2vq015sxlabqp068pgqf8mdbmwzhf";
  };

  defaultNix = writeText "default.nix" ''
    { buildMaven }:
    (buildMaven ./project-info.json).build
  '';

  src = runCommand "src-with-info" {} '' 
    mkdir -p $out
    cp -r ${gitSrc}/* $out
    cp ${./project-info.json} $out/project-info.json
    cp ${defaultNix} $out/default.nix
  '';
in

callPackage (import src) {}
