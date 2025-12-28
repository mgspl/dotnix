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
