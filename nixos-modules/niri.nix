{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.nixosModules.niri
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/miguel";

    # Custom config files for non-standard config locations
    configFiles = [
      "/home/miguel/.config/DankMaterialShell/settings.json"
    ];

    # Save the logs to a file
    logs = {
      save = false;
      path = "/tmp/dms-greeter.log";
    };

    # Custom Quickshell Package
    quickshell.package =
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.override
        {
          withX11 = false;
          withCrashReporter = false;
        };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  environment.systemPackages = with pkgs; [
    wayland-utils
    xwayland-satellite-unstable
  ];
  environment.variables.NIXOS_OZONE_WL = "1";
}
