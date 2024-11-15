{ pkgs }:
pkgs.runCommandNoCCLocal "fmt-check"
  {
    src = ../.;
    nativeBuildInputs = [ pkgs.nixfmt-rfc-style ];
  }
  ''
    nixfmt --check $src
    echo "Passed: nixfmt check"
    touch $out
  ''
