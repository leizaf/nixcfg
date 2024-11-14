{ pkgs, ... }: {
  imports = [ ./configuration.nix ];

  powerManagement.cpuFreqGovernor = "performance";
}
