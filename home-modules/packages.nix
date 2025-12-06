{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    # Programs
    loupe
    nautilus
    papers
    gnome-calculator
    gnome-text-editor
    shotcut

    inputs.ev357-nurpkgs.packages.${pkgs.stdenv.hostPlatform.system}.helium
    inputs.loneros-nurpkgs.packages.${pkgs.stdenv.hostPlatform.system}.pear-desktop

    # Tools
    unzip
    zip
    killall
    wlr-randr
    pamixer
    microfetch
    ffmpegthumbnailer

    # Compositor
    playerctl
    imagemagick
    wl-clipboard
    xdg-utils
    xdg-user-dirs
  ];
}
