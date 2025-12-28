{
  pkgs,
  inputs,
  ...
}:
{
  # Enable NTSync
  boot.kernelModules = [ "ntsync" ];

  environment.systemPackages = [
    pkgs.mangohud
    #pkgs.mangojuice
  ];

  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;

    package = pkgs.steam.override {
      # some launch args that work better for me
      extraArgs = "-silent -system-composer -skipstreamingdrivers -cef-disable-breakpad -cef-disable-seccomp-sandbox -cef-disable-js-logging -no-cef-sandbox";
      extraEnv = {
        MANGOHUD = true;
        OBS_VKCAPTURE = true;
        PROTON_USE_NTSYNC = true;
        PROTON_USE_WAYLAND = true;
        LD_PRELOAD = "";
      };
    };

    extraCompatPackages = [
      inputs.forkprince-nurpkgs.packages.${pkgs.stdenv.hostPlatform.system}.proton-cachyos-v3-bin
    ];
  };
}
