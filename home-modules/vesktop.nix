{ pkgs, ...}:
{
  catppuccin.vesktop = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };

  home.packages = [
    pkgs.vesktop
  ];
}
