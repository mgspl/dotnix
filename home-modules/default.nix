{ inputs, ... }:
{
  imports = [
    ./btop.nix
    ./dms.nix
    ./firefox.nix
    ./kitty.nix
    ./mpv.nix
    ./niri.nix
    ./packages.nix
    ./starship.nix
    ./vesktop.nix
    ./zed.nix
  ];

  programs.home-manager.enable = true;

  nix = {
    settings = {
      builders-use-substitutes = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      log-lines = 20;

      max-jobs = "auto";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      #(import ../packages/overlay.nix)
      inputs.niri.overlays.niri
    ];
  };
}
