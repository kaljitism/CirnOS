{
pkgs, username, config, ... }: {
  # nix
  documentation.nixos.enable = false; # .desktop
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
      # Nixpkgs-Wayland
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://nix-community.cachix.org"
      # Nix-community
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      # Nixpkgs-Wayland
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      # Nix-community
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # virtualisation
   virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      enableNvidia = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  


  nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
              ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  services = {
    blueman.enable = true;
    envfs.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
          user = "greeter";
        };
      };
    };
    gvfs.enable = true;
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [
          pkgs.nautilus-open-any-terminal
        ];
      };
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
    ];
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = { };
    pam.services.swaylock-effects = {};
  };

  # dconf
  programs = {
    zsh.enable = true;
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    firefox = {
      enable = true;
      nativeMessagingHosts.packages = [ pkgs.plasma5Packages.plasma-browser-integration ];
    };
    # Run dynamically linked stuff
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Add any missing dynamic libraries for unpackaged programs
        # here, NOT in environment.systemPackages
      ];
    };
  };

  # packages
  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; with nodePackages_latest; with gnome; with libsForQt5; [
      fish
      timer
      speechd
      lolcat
      ranger      
      emacs-gtk
      nvidia-podman
      nvidia-docker
      dive # look into docker image layers
      podman-tui # status of containers in the terminal
      docker-compose # start group of containers for dev
      podman-compose # start group of containers for dev      
      podman
      docker
      glxinfo
      distrobox
      neovim
      bitwig-studio
      krita
      davinci-resolve
      obsidian
      blender
      inkscape-with-extensions
      reaper
      wine
      SDL2.dev
      SDL2
      tmux
      fzf
      zoxide
      hyprpaper
      blueman
      curl
      zsh
      git
      gh
      kate
      gnomeExtensions.wallpaper-slideshow
      vim
      lf
      mangohud
      # home-manager
      wget
      nixpkgs-fmt
      nixfmt
      discord
      spotify
      hakuneko
      calibre
      torrential
      lutris

      coreutils
      clang

      i3 # gaming
      sway  

      # Development
      jetbrains.jdk
      jetbrains.idea-ultimate
      jetbrains.webstorm
      jetbrains.datagrip
      jetbrains.clion
      android-studio
      dart
      flutter
      nodejs
      gjs
      bun
      cargo
      go
      gcc
      typescript
      eslint
      # very important stuff
      uwuify


      # gui
      blueberry
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      d-spy
      dolphin
      figma-linux
      kolourpaint
      github-desktop
      gnome.nautilus
      icon-library
      dconf-editor
      qt5.qtimageformats
      vlc
      yad

      # tools
      z-lua
      bat
      eza
      fd
      ripgrep
      fzf
      socat
      jq
      gojq
      acpi
      ffmpeg
      libnotify
      killall
      zip
      unzip
      glib
      foot
      kitty
      starship
      showmethekey
      vscode
      ydotool

      # theming tools
      gradience
      gnome-tweaks

      # hyprland
      brightnessctl
      cliphist
      fuzzel
      grim
      hyprpicker
      tesseract
      imagemagick
      pavucontrol
      playerctl
      swappy
      swaylock-effects
      swayidle
      slurp
      swww
      wayshot
      wlsunset
      wl-clipboard
      wf-recorder
    ];
  };

  qt.enable = true;

  # ZRAM
  zramSwap.enable = true;
  zramSwap.memoryPercent = 100; 

  nixpkgs.overlays = [
    (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
  ];

  # logind
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
  '';
  # user
  users = {
    users.${username} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "video" "input" "uinput" "libvirtd" "docker" "podman" ];
    };
  };

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Boot
  boot = {
    supportedFilesystems = [ "btrfs" "ext4" "fat32" "ntfs" ];
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # kernelPatches = [{
    #   name = "enable RT_FULL";
    #   patch = null;
    #   # TODO: add realtime patch: PREEMPT_RT y
    #   extraConfig = ''
    #     PREEMPT y
    #     PREEMPT_BUILD y
    #     PREEMPT_VOLUNTARY n
    #     PREEMPT_COUNT y
    #     PREEMPTION y
    #   '';
    # }];
    # extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    # kernelModules = [ "acpi_call" ];
    # make 3.5mm jack work
    # extraModprobeConfig = ''
    #   options snd_hda_intel model=headset-mode
    # '';
  };

  system.stateVersion = "24.05";
}
