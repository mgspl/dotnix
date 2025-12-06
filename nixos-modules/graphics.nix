{ pkgs, ... }:
{
  hardware = {
    cpu = {
      amd.updateMicrocode = true;
    };
    enableRedistributableFirmware = true;

    graphics = {
      enable = true;
      package = pkgs.mesa;
      package32 = pkgs.pkgsi686Linux.mesa;

    };
  };

  # Control fan curve
  programs.coolercontrol.enable = true;

  # LACT
  services.lact.enable = false;

  programs.corefreq.enable = false;
}
