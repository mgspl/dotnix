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
    inputs.chaotic.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
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
