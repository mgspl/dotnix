{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./catppuccin.nix
    ./chaotic.nix
    ./fonts.nix
    ./gaming.nix
    ./gsr.nix
    ./graphics.nix
    ./lanzaboote.nix
    ./lix.nix
    ./niri.nix
    ./nh.nix
    ./openrgb.nix
    ./performance.nix
    ./security.nix
    ./tuned.nix
  ];

  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_cachyos;
    #extraModulePackages = with config.boot.kernelPackages; [zenpower];
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "amd_pstate=active"
      "nosplit_lock_mitigate"
    ];
    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
    };
    initrd.systemd = {
      enable = true;
      settings.Manager = {
        DefaultTimeoutStartSec = "15s";
        DefaultTimeoutStopSec = "10s";
        DefaultLimitNOFILE = "2048:2097152";
      };
    };
  };

  networking = {
    hostFiles = [
      (pkgs.fetchurl {
        url = "https://hblock.molinero.dev/hosts";
        hash = "sha256-U6N1el1oejYNMJI1A507KqsuNNcL7B8KTL6/VVQr4aI=";
      })
    ];
    networkmanager = {
      enable = true;
    };
  };

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
    # keyMap = "br";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Configure keymap in X11
  services = {
    xserver = {
      xkb.layout = "br";
      exportConfiguration = true;
    };
    gvfs.enable = true;
    upower.enable = true;
    gnome = {
      gnome-keyring.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    fstrim = {
      enable = true;
      interval = "weekly"; # the default
    };
  };

  programs.dconf.enable = true;

  documentation.nixos.enable = false;

  users.users.miguel = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    description = "Miguel";
  };

  environment.pathsToLink = [ "/share/bash-completion" ];

  environment.systemPackages = with pkgs; [
    git
    wl-clipboard
  ];

  # Enable App Armor
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
  };

  # Limit systemd journal size and disable coredumps
  services.journald.extraConfig = ''
    SystemMaxUse=500M
    RuntimeMaxUse=10M
  '';
  systemd.coredump = {
    enable = false;
    extraConfig = ''
      Storage=none
      ProcessSizeMax=0
    '';
  };

  # Frmware updater
  services.fwupd = {
    enable = true;
    daemonSettings.EspLocation = config.boot.loader.efi.efiSysMountPoint;
  };

  system.stateVersion = "23.11";
}
