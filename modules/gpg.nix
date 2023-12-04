{ pkgs, ... }:
{
  services.gpg-agent = {
    enableSshSupport = true;
    enableExtraSocket = true;
    pinentryFlavor = "qt";
  };
}
