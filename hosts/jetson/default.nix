{ som, ... }:
let
  jetpack-nixos = builtins.fetchTarball {
    url = "https://github.com/anduril/jetpack-nixos/archive/master.tar.gz";
    sha256 = "sha256:0wav67x2q0ll44a31ca014aynahg3fdvfbq6yq5h2dbv17fsjp27";
  };
in
{
  imports = [
    "${jetpack-nixos}/modules"
    ./hardware-configuration.nix
  ];

  boot = {
    kernelParams = [
      "pcie_aspm=off"
      "video=efifb:off"
    ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
  hardware.nvidia-jetpack = {
    enable = true;
    firmware.autoUpdate = true;
    carrierBoard = "devkit";
    inherit som;
  };

  services.nvpmodel.enable = true;

  time.timeZone = "America/Los_Angeles";

  networking = {
    hostName = "lfu-agx";
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;

    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.3.250";
        prefixLength = 24;
      }
    ];
  };

  systemd.network = {
    enable = true;
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "24.11";
}
