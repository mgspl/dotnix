{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      inherit (final.lixPackageSets.stable)
        nixpkgs-review
        nix-direnv
        nix-eval-jobs
        nix-fast-build
        colmena
        nil
        nixd
        ;
    })
    inputs.niri.overlays.niri
    (import ../packages/overlay.nix)
  ];

  # nix configs
  nix = {
    channel.enable = false;
    package = pkgs.lixPackageSets.stable.lix;
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      builders-use-substitutes = true;
      trusted-users = [ "@wheel" ];
      max-jobs = "auto";
    };
  };

}
