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


let
  wrapWithJack = pkg: bin: pkgs.symlinkJoin {
    name = "${bin}-pipewire-jack";
    paths = [ pkg ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/${bin} \
        --prefix LD_LIBRARY_PATH : ${pkgs.pipewire.jack}/lib
    '';
  };
in

{
  imports =
    [
      ./hardware-configuration.nix
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

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.hyprland = {
  	enable = true;
    xwayland.enable = true;
    withUWSM = false;
  };


  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [
          "main"
          "brackets"
        ];
      styles = {
        "alias" = "fg=magenta,bold";
      };
    };
    autosuggestions = {
      enable = true;
      strategy =  [
        "match_prev_cmd"
        "history"
        # "completion"
      ];
      highlightStyle = "fg=8";
    };
    interactiveShellInit = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      function zvm_config() {
        ZVM_SYSTEM_CLIPBOARD_ENABLED=true
        ZVM_VI_HIGHLIGHT_FOREGROUND=green
        ZVM_VI_HIGHLIGHT_BACKGROUND=#008800
      }
    '';
  };

  programs.kdeconnect.enable = true;

  programs.thunderbird = {
    enable = true;
  };

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };
  # programs.walker.enable = true;

  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
  };


  programs.chromium = {
    enable = true;
    extraOpts = {
      "PasswordManagerEnabled" = false;
      "SpellcheckLanguage" = [
        "es-MX"
        "en-US"
      ];

    };
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
      "hdhinadidafjejdhmfkjgnolgimiaplp" # Read Aloud: A Text to Speech Voice Reader
      "hoombieeljmmljlkjmnheibnpciblicm" # Language reactor
    ];

    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://encrypted.google.com/search?q={searchTerms}&{google:RLZ}{google:originalQueryForSuggestion}{google:assistedQueryStats}{google:searchFieldtrialParameter}{google:searchClient}{google:sourceId}{google:instantExtendedEnabledParameter}ie={inputEncoding}";

    enablePlasmaBrowserIntegration = true;
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


  services.input-remapper = {
    enable = true;
    enableUdevRules = true;  # recommended for hotplugged devices
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

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
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


  systemd.user.targets.hyprland-session = {
    description = "Hyprland session";
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };


  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
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
  security = {
    rtkit.enable = true;
    pam.loginLimits = [
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "99";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "soft";
        value = "99999";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "hard";
        value = "99999";
      }
    ];
  };

  security.polkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    extraConfig = {
      pipewire = {
        "10-clock-settings" = {
          "context.properties" = {
            "default.clock.allowed-rates" = [ 44100 48000 96000 192000 ];
            "default.clock.rate" = 48000;

            "default.clock.quantum" = 512;
            "default.clock.min-quantum" = 16;
            "default.clock.max-quantum" = 2048;
            "default.clock.quantum-limit" = 2048;
            "default.clock.quantum-floor" = 4;
          };
        };

        "10-virt-audio-1" = {
          "context.objects" = [
            {
              "factory" = "adapter";
              "args" = {
                "factory.name" = "support.null-audio-sink";
                "node.name" = "Main_Audio";
                "media.class" = "Audio/Sink";
                "audio.position" = [ "FL" "FR" ];
                "monitor.channel-volumes" = true;
                "monitor.passthrough" = true;
              };
            }
          ];
        };

        "62-chat-audio" = {
          "context.modules" = [
            {
              "name" = "libpipewire-module-loopback";
              "args" = {
                "node.description" = "Chat Audio";
                "capture.props" = {
                  "node.name" = "chat_audio";
                  "media.class" = "Audio/Sink";
                  "audio.position" = [ "FL" "FR" ];
                };
                "playback.props" = {
                  "node.name" = "playback.chat_audio";
                  "audio.position" = [ "FL" "FR" ];
                  "node.target" = "combined_output";
                  "node.passive" = true;
                };
              };
            }
          ];
        };
      };

      client = {
        "56-force-chat-audio" = {
          "stream.rules" = [
            {
              "matches" = [
                { "node.name" = "~.Telegram.*"; }
              ];
              "actions" = {
                "update-props" = {
                  "target.object" = "chat_audio";
                };
              };
            }
          ];
        };
      };

      pipewire-pulse = {
        "57-force-chat-audio" = {
          "stream.rules" = [
            {
              "matches" = [
                { "application.name" = "Stoat"; }
              ];
              "actions" = {
                "update-props" = {
                  "target.object" = "chat_audio";
                };
              };
            }
            {
              "matches" = [
                { "application.process.binary" = ".Discord-wrapped"; }
              ];
              "actions" = {
                "update-props" = {
                  "target.object" = "chat_audio";
                };
              };
            }
          ];
        };
      };

    };








    wireplumber.enable = true;
     wireplumber.extraConfig = {
       "10-bluez-monitor" = {
         "monitor.bluez.properties" = {
           "bluez5.enable-sbc-xq" = true;
           "bluez5.enable-msbc" = true;
           "bluez5.enable-hw-volume" = true;

           # Explicitly enable the native backend for hands-free
           "bluez5.hfphsp-backend" = "native";

           # Corrected WirePlumber role strings
           "bluez5.roles" = [
             "a2dp_sink"
             "a2dp_source"
             "bap_sink"
             "bap_source"
             "hsp_hs"
             "hsp_ag"
             "hfp_hf"
             "hfp_ag"
           ];
         };
       };

       "11-bluetooth-policy" = {
         "wireplumber.settings" = {
           # Still telling WirePlumber to never automatically switch to it
           "bluetooth.autoswitch-to-headset-profile" = false;
         };
       };
    };



  };


  services.udisks2.enable = true;

  services.dunst.enable = true;

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

  # musnix.enable = true;

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
     shell = pkgs.zsh;
     packages = with pkgs; [
       tree
     ];
   };



  environment.etc."xdg/menus/applications.menu".source =
  "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

#   environment.sessionVariables.LD_LIBRARY_PATH = [
#   "${pkgs.pipewire.jack}/lib"
# ];

  environment.systemPackages = with pkgs; [
    vim
    neovim
    tree-sitter
    wget
    git
    btop
    bat
    lsd
    yt-dlp
    kitty
    ydotool
    gcc
    yazi
    zsh-powerlevel10k
    ripgrep
    neovim-remote



    hyprcursor
    hyprpaper
    hyprlauncher
    hyprshutdown
    wl-clipboard
    grimblast
    wayscriber


    adwaita-icon-theme
    sddm-astronaut

    bluetui
    wiremix
    pavucontrol
    # qjackctl
    qpwgraph
    pear-desktop

    telegram-desktop
    stoat-desktop
    discord

    anki

    pureref
    davinci-resolve
    kdePackages.kdenlive

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
    houdini
    godot

    aseprite
    blockbench

    godotPackages_4_7.godot
    gimp
    inkscape
    graphite
    friction-graphics

    # pipewire.jack
    # libjack2
    audacity
    # ardourPipewire
    # ardour
    # reaper
    (wrapWithJack ardour "ardour9")
    (wrapWithJack reaper "reaper")
    lmms

    # brave
    (pkgs.symlinkJoin {
      name = "brave";
      paths = [ pkgs.brave ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/brave \
          --add-flags "--disable-features=WaylandFractionalScaleV1"

        # Patch the .desktop file to use the wrapper instead of the store path
        sed -i "s|Exec=.*brave|Exec=$out/bin/brave|g" \
          $out/share/applications/brave-browser.desktop
      '';
    })
    firefoxpwa
    krita

    retroarch
    heroic
    bottles
    lutris
    protonplus


    calibre

    mpv
    # kdePackages.plasma-workspace
    kdePackages.kservice
    kdePackages.qtsvg
    kdePackages.kio # needed since 25.11
    kdePackages.kio-fuse #to mount remote filesystems via FUSE
    kdePackages.kio-extras #extra protocols support (sftp, fish and more)
    kdePackages.dolphin # This is the actual dolphin package
    kdePackages.dolphin-plugins
    kdePackages.solid        # device detection
    # kdePackages.baloo-widgets
    # kdePackages.baloo
    kdePackages.xdg-desktop-portal-kde
    kdePackages.qtwayland
    kdePackages.polkit-kde-agent-1


    kdePackages.ark
    p7zip       # Support for 7z and rar formats
    unzip       # Standard zip extraction
    gnutar      # Tar archive support


  ];


  nixpkgs.overlays = [
    (final: prev: {
      stoat-desktop = prev.stoat-desktop.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ prev.makeWrapper ];
        postFixup = (old.postFixup or "") + ''
          wrapProgram $out/bin/stoat-desktop \
            --set PULSE_PROP_OVERRIDE "application.name=Stoat"
        '';
      });
    })
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


  nix.settings = {
    use-xdg-base-directories = true;
    experimental-features = [ "nix-command" "flakes" ];
  };



  system.stateVersion = "26.05";
}
