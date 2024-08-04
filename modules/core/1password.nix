{ ... }:
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "lfu" ];
  };
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        brave
        chrome
      '';
      mode = "0755";
    };
  };
}
