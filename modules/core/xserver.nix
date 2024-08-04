{ username, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkbVariant = "";
      xkb.layout = "us";
    };

    displayManager.autoLogin = {
      enable = true;
      user = "${username}";
    };

    libinput = {
      enable = true;
    };
  };

  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
