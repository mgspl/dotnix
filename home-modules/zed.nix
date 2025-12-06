{
  lib,
  pkgs,
  ...
}:
{
  catppuccin.zed = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
    icons = {
      enable = true;
      flavor = "mocha";
    };
  };
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-fhs;
    extraPackages = with pkgs; [
      nil
      alejandra
    ];

    extensions = [
      # Language/Tool Support
      "nix"
    ];

    userSettings = {
      format_on_save = "on";
      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter = {
            external = {
              command = lib.getExe pkgs.alejandra;
            };
          };
        };
      };
    };
  };
}
