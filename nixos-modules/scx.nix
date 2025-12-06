{ pkgs, ... }:
{
  services.scx = {
    enable = true;
    scheduler = "scx_cosmos";
    package = pkgs.scx.rustscheds;
    extraArgs = [ "-c 0 -p 0" ];
  };
}
