{
  pkgs,
  lib,
  ...
}:
{
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 15;
  };

  systemd.oomd = {
    enable = lib.mkForce true;
    enableRootSlice = true;
    enableUserSlices = true;
    enableSystemSlice = true;
    settings.OOM = {
      "DefaultMemoryPressureDurationSec" = "20s";
    };
  };

  services = {
    bpftune.enable = true;
    scx = {
      enable = true;
      package = pkgs.scx.rustscheds;
      scheduler = "scx_flash";
      extraArgs = [ "-m all" ];
    };
  };

  # Enable User Queue
  environment.variables = {
    AMD_USERQ = 1;
  };

  # Garuda Tweaks
  boot.kernel.sysctl = {
    "kernel.nmi_watchdog" = 0;
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "net.core.rmem_max" = 2500000;
    "vm.max_map_count" = 16777216;
    # ZRAM is relatively cheap, prefer swap
    "vm.swappiness" = 180;
    # ZRAM is in memory, no need to readahead
    "vm.page-cluster" = 0;

    # Network Tweaks from garuda
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_fin_timeout" = 5;

    "kernel.split_lock_mitigate" = 0;
  };

  # Enable BBR
  boot.kernelModules = [ "tcp_bbr" ];
}
