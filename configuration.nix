{ config, lib, pkgs, ... }:

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

  services.displayManager.sddm = {
  	enable = true;
	wayland.enable = true;
	settings = {
		Theme = {
			CursorTheme = "Adwaita";
			CursorSize = 24;
		};
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


  services.kanata = {
    enable = true;
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

     ];
     packages = with pkgs; [
       tree
     ];
   };

  programs.firefox.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      "chlffgpmiacpedhhbkiomidkjlcfhogd" # pushbullet
      "mbniclmhobmnbdlbpiphghaielnnpgdp" # lightshot
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
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

    hyprpaper
    hyprlauncher
    hyprshutdown

    adwaita-icon-theme

    bluetui
    wiremix

    telegram-desktop
    # stoat-desktop
    discord

    anki
    davinci-resolve
    # (blender.override { rocmSupport = true; })
    # blender
    pkgsRocm.blender
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
  nixpkgs.config = {
    allowUnfree = true;
    # rocmSupport = true;
  };

  hardware.amdgpu.opencl.enable = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];



  system.stateVersion = "26.05";
}

