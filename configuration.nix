{ config, lib, pkgs, ... }:

let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";  # or any other theme
    themeConfig = {
      # Customize colors and settings
      HeaderTextColor = "#d5c4a1";
      # Background = "Backgrounds/your-custom-background.png";
      # ... other theme configuration options
    };
  };
in

{
  imports =
    [
      ./hardware-configuration.nix
      # inputs.walker.nixosModules.default
    ];

  boot.loader.grub = {
  	enable = true;
	efiSupport = true;
	configurationLimit = 10;
	device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Alpha";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Mexico_City";

  programs.hyprland = {
  	enable = true;
	xwayland.enable = true;
	withUWSM = true;
  };

  xdg = {
    menus.enable = true;
  };


  programs.thunderbird = {
    enable = true;
  };

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };
  # programs.walker.enable = true;

  programs.firefox.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      "chlffgpmiacpedhhbkiomidkjlcfhogd" # pushbullet
      "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin Chrome Theme - Mocha
      "mbniclmhobmnbdlbpiphghaielnnpgdp" # lightshot
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "nffaoalbilbmmfgbnbgppjihopabppdk" # Video Speed Controller
      "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
      "ldgfbffkinooeloadekpmfoklnobpien" # Raindrop
      "jinjaccalgkegednnccohejagnlnfdag" # Violentmonkey
    ];

  };

  programs.steam = {
    enable = true;
    extest.enable = true;
    protontricks.enable = true;
    remotePlay.openFirewall = true;
    extraPackages = with pkgs; [
      mangohud        # FPS/performance overlay
      gamemode        # CPU/GPU performance boost while gaming
    ];
  };

  programs.gamemode = {
    enable = true;
  };


  services.kanata = {
    enable = true;
    keyboards = {
      akko3068 = {
        devices = [ "/dev/input/by-id/usb-AKKO_AKKO_3068BT-event-kbd" ];
        config = builtins.readFile ./config/kanata/akko_3068.kbd;
      };
    };
  };

  services.displayManager.sddm = {
  	enable = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia # Required for video backgrounds/audio
    ];
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        CursorSize = 60;
        CursorTheme = "Adwaita";
      };
    };
  };


  systemd.services.sddm-cursor-warp = {
    description = "Warp cursor to DP-1 center on SDDM start";
    wantedBy = [ "display-manager.service" ];
    after = [ "display-manager.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ydotool}/bin/ydotool mousemove --absolute -x 0 -y 720";
    };
  };


  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
  	LC_TIME = "es_MX.UTF-8";
  	LC_MONETARY = "es_MX.UTF-8";
  	LC_MEASUREMENT = "es_MX.UTF-8";
  	LC_NUMERIC = "es_MX.UTF-8";
  };
  console = {
	font = "Lat2-Terminus16";
	keyMap = "us";
  };



  services.printing.enable = true;

  # Add rtkit for realtime scheduling (recommended)
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    wireplumber.enable = true;
  };


  # Add this alongside your existing services.pipewire block:
  services.pipewire.wireplumber.extraConfig."10-bluez" = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;   # Better quality SBC
      "bluez5.enable-msbc"   = true;   # Better call quality
      "bluez5.enable-hw-volume" = true;
      # "bluez5.roles" = [
      #   "hsp_hs"
      #   "hsp_ag"
      #   "hfp_hf"
      #   "hfp_ag"
      # ];
    };
  };

  services.libinput.enable = true;

  services.openssh.enable = true;

  hardware.opentabletdriver = {
  	enable = true;
	daemon.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;  # auto-power on after boot
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;  # enables battery level reporting, etc.
      };
    };
  };

  services.blueman.enable = true;  # GUI manager (optional but recommended)


  users.users.izaird = {
     isNormalUser = true;
     extraGroups = [
     	"wheel"
     	"audio"
     	"realtime"
     	"networkmanager"
     	"input"
      "uinput"

     ];
     packages = with pkgs; [
       tree
     ];
   };



  environment.etc."xdg/menus/applications.menu".source =
  "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  environment.systemPackages = with pkgs; [
    vim
    neovim
    tree-sitter
    wget
    git
    btop
    kitty
    ydotool

    hyprcursor
    hyprpaper
    hyprlauncher
    hyprshutdown

    adwaita-icon-theme
    sddm-astronaut

    bluetui
    wiremix
    pavucontrol

    telegram-desktop
    # stoat-desktop
    discord

    anki
    davinci-resolve
    # pkgsRocm.blender
    (pkgs.symlinkJoin {
      name = "blender";
      paths = [ pkgsRocm.blender ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/blender \
          --set LD_PRELOAD "${pkgsRocm.rocmPackages.rocm-comgr}/lib/libamd_comgr.so.3"
      '';
    })
    godot
    gimp
    inkscape
    graphite
    friction-graphics

    brave
    krita
    mpv
    # kdePackages.plasma-workspace
    kdePackages.kservice
    kdePackages.qtsvg
    kdePackages.kio # needed since 25.11
    kdePackages.kio-fuse #to mount remote filesystems via FUSE
    kdePackages.kio-extras #extra protocols support (sftp, fish and more)
    kdePackages.dolphin # This is the actual dolphin package
    kdePackages.dolphin-plugins
    # kdePackages.baloo-widgets
    # kdePackages.baloo


  ];



  fileSystems."/home/izaird/Projects" = {
    device = "/dev/disk/by-uuid/8a305523-3f1b-467e-b9f0-f3c8f13d6761";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/ad2e0e92-aee0-4401-90b6-5b3677fcca8e";
    fsType = "ext4";
  };


  nixpkgs.config = {
    allowUnfree = true;
    # rocmSupport = true;
  };

  hardware.amdgpu.opencl.enable = true;

  # programs.nix-ld.enable = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];



  system.stateVersion = "26.05";
}
