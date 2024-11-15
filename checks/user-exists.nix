{
  pkgs,
  username,
  nixosConfigurations,
}:
let
  lib = pkgs.lib;
  checks = lib.strings.concatMapStrings (
    attr:
    if attr.value.config.users.users ? ${username} then
      ""
    else
      ''
        echo "Error: ${username} is not a defined user!" >&2
        exit 1
      ''
  ) (lib.attrsToList nixosConfigurations);
  checkPhase =
    checks
    + ''
      echo "Passed: user exists check"
      touch $out
    '';
in
pkgs.runCommandNoCCLocal "user-exists-check" { } checkPhase
