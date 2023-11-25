{ pkgs, ... }:
{
  services.gpg-agent = {
    enableSshSupport = true;
    pinentryFlavor = "qt";
  };
}
