{ config, pkgs, ... }:

let
  xcursor-pro-hyprcursor = pkgs.fetchFromGitHub {
    owner = "4lrick";
    repo = "XCursor-Pro-Hyprcursor";
    rev = "5cefd976fda4e187c5daf249e8da261659c8518c";
    hash = "sha256-OCARYM03MW4Y9tvKJPV2u5VJbR7eJ2KPP0IMuGae3fs=";
  };

  # gdshader-language-server = pkgs.callPackage ./pkgs/gdshader-language-server.nix { };
  gdshader-lsp-cpp = pkgs.callPackage ./pkgs/gdshader-lsp-cpp.nix { };
in

{
	home.username = "izaird";
	home.homeDirectory = "/home/izaird";
	home.stateVersion = "26.05";

  xdg.enable = true;

  programs.oh-my-posh = {
    enable = false;
    enableZshIntegration = true; # For Zsh
    enableBashIntegration = true; # For Bash
    useTheme = "jandedobbeleer"; # Example of a built-in theme
    # settings = builtins.fromTOML (builtins.readFile ./config/ohmyposh/jandedobbeleer.toml);
};


	programs.zsh = {
		enable = true;

    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"
      compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

      # source "$HOME/Projects/Code/RiceField/config/zsh/vim_complete_menu"
      # source "$HOME/Projects/Code/RiceField/config/zsh/OMP_zsh-vi-mode_integration"


    '';

    history = {
      path = "$XDG_STATE_HOME/zsh/history";
    };

    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
      TERMINAL_PROG = "kitty";
      BROWSER = "brave";

      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
      ZVM_SYSTEM_CLIPBOARD_ENABLED = "true";

      # # XDG
      # XDG_CONFIG_HOME = "$XDG_CONFIG_HOME";
      # XDG_DATA_HOME   = "$XDG_DATA_HOME";
      # XDG_STATE_HOME  = "$XDG_STATE_HOME";
      # XDG_CACHE_HOME  = "$XDG_CACHE_HOME";


      # Tool homes
      DUB_HOME        = "$XDG_DATA_HOME/dub";
      ANDROID_USER_HOME = "$XDG_DATA_HOME/android";
      ANDROID_SDK_HOME  = "$XDG_CONFIG_HOME/android";
      ANDROID_AVD_HOME  = "$XDG_DATA_HOME/android/avd";
      CARGO_HOME      = "$XDG_DATA_HOME/cargo";
      RUSTUP_HOME     = "$XDG_DATA_HOME/rustup";
      DOTNET_CLI_HOME = "$XDG_DATA_HOME/dotnet";
      GNUPGHOME       = "$XDG_DATA_HOME/gnupg";
      GRADLE_USER_HOME = "$XDG_DATA_HOME/gradle";
      GOPATH          = "$XDG_DATA_HOME/go";
      GOMODCACHE      = "$XDG_CACHE_HOME/go/mod";
      XCOMPOSECACHE="$XDG_CACHE_HOME/X11/xcompose";
      ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority";
      NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/npmrc";
      XINITRC         = "$XDG_CONFIG_HOME/x11/xinitrc";
      NOTMUCH_CONFIG  = "$XDG_CONFIG_HOME/notmuch-config";
      GTK2_RC_FILES   = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0";
      WGETRC          = "$XDG_CONFIG_HOME/wget/wgetrc";
      INPUTRC         = "$XDG_CONFIG_HOME/shell/inputrc";
      ZDOTDIR         = "$XDG_CONFIG_HOME/zsh";
      WINEPREFIX      = "$XDG_DATA_HOME/wineprefixes/default";
      KODI_DATA       = "$XDG_DATA_HOME/kodi";
      PASSWORD_STORE_DIR = "$XDG_DATA_HOME/password-store";
      TMUX_TMPDIR     = "/run/user/1000";  # or "$XDG_RUNTIME_DIR" if set before
      ANSIBLE_CONFIG  = "$XDG_CONFIG_HOME/ansible/ansible.cfg";
      IPYTHONDIR      = "$XDG_CONFIG_HOME/ipython/";
      PYTHON_HISTORY  = "$XDG_STATE_HOME/python/history";
      HISTFILE = "$XDG_STATE_HOME/bash/history";
      MBSYNCRC        = "$XDG_CONFIG_HOME/mbsync/config";
      ELECTRUMDIR     = "$XDG_DATA_HOME/electrum";
      PYTHONSTARTUP   = "$XDG_CONFIG_HOME/python/pythonrc.py";
      SQLITE_HISTORY  = "$XDG_STATE_HOME/sqlite_history";
      WEECHAT_HOME    = "$XDG_CONFIG_HOME/weechat";
      PULSE_COOKIE    = "$XDG_CONFIG_HOME/pulse/cookie";
      MPLAYER_HOME    = "$XDG_CONFIG_HOME/mplayer";
      TS3_CONFIG_DIR  = "$XDG_CONFIG_HOME/ts3client";
      UNISON          = "$XDG_DATA_HOME/unison";

      _JAVA_OPTIONS   = "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java -Djavafx.cachedir=$XDG_CACHE_HOME/openjfx";

      # Other programs
      DICS            = "/usr/share/stardict/dic/";
      SUDO_ASKPASS    = "$HOME/.local/bin/dmenupass";
      FZF_DEFAULT_OPTS = "--layout=reverse --height 40%";

      MANROFFOPT      = "-c -Tutf8";
      MANPAGER        = "less -R --use-color -Dd+g -Du+Bu -Ds+ys -DM+c";
      MANWIDTH        = "90";
      MOZ_USE_XINPUT2 = "1";
      AWT_TOOLKIT     = "MToolkit wmname LG3D";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      GRIM_DEFAULT_DIR    = "$HOME/Pictures/Screenshots";
      XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots";
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };


		shellAliases = {
      # Neovim
      vim     = "nvim";
      vimdiff = "nvim -d";

      # Sudo-wrapped system commands
      mount    = "sudo mount";
      umount   = "sudo umount";
      sv       = "sudo sv";
      pacman   = "sudo pacman";
      updatedb = "sudo updatedb";
      su       = "sudo su";
      shutdown = "sudo shutdown";
      poweroff = "sudo poweroff";
      reboot   = "sudo reboot";

      # cp/mv/rm with sane defaults
      cp  = "cp -iv";
      mv  = "mv -iv";
      rm  = "rm -vI";
      mkd = "mkdir -pv";

      # Media
      yt    = "yt-dlp --embed-metadata -i";
      yta   = "yt -x -f bestaudio/best";
      ytt   = "yt --skip-download --write-thumbnail";
      ffmpeg = "ffmpeg -hide_banner";

      # Color
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      ccat = "highlight --out-format=ansi";
      ip   = "ip -color=auto";

      # lsd replacements
      l   = "lsd --group-dirs=first";
      ls  = "lsd --group-dirs=first";
      ll  = "lsd -lh --group-dirs=first";
      la  = "lsd -a --group-dirs=first";
      lla = "lsd -lhaA --group-dirs=first";
      cat = "bat";

      # Short forms
      ka   = "killall";
      g    = "git";
      trem = "transmission-remote";
      YT   = "youtube-viewer";
      sdn  = "shutdown -h now";
      v    = "nvim";
      p    = "pacman";

      # Git
      gs   = "git status";
      gb   = "git branch";
      ga   = "git add";
      gc   = "git commit";
      gp   = "git push";
      gpo  = "git push origin";
      gplo = "git pull origin";
      gd   = "git diff";
      gl   = "git log";
      glo  = "git log --pretty=oneline";
      glol = "git log --all --decorate --oneline --graph";

      # Nix
      nshell = "nix-shell --run zsh -p";
      ninsta = "nix-instantiate --eval ";


      # Misc
      magit = "nvim -c MagitOnly";
      ref   = "shortcuts >/dev/null; source $XDG_CONFIG_HOME/shell/shortcutrc; source $HOME/.config/shell/zshnameddirrc";
      weath = "less -S $XDG_DATA_HOME/weatherreport";
      svn   = "svn --config-dir $XDG_CONFIG_HOME/subversion";
      adb   = "HOME=$XDG_DATA_HOME/android adb";
		};
	};

	  systemd.user.tmpfiles.rules = [
	    "d %h/Documents 0755 - - -"
	    "d %h/Downloads 0755 - - -"
	    "d %h/Pictures  0755 - - -"
	    "d %h/Videos    0755 - - -"
	    "d %h/Music     0755 - - -"
	    "d %h/Games     0755 - - -"
	  ];

  home.sessionPath = [ "$HOME/.local/bin" ];

  # programs.neovim = {
  #   enable = true;
  #   plugins = [
  #     pkgs.vimPlugins.nvim-treesitter
  #   ];
  # };
	# home.file.".config/hypr".source = ./config/hypr;
	home.file.".config/kitty".source = ./config/kitty;
	home.file.".config/git".source = ./config/git;
  home.file.".local/bin/godot-nvr.sh" = {
    source = ./local/bin/godot-nvr;
    executable = true;
  };


  home.packages = with pkgs; [
    hyprcursor
    xcursor-pro-hyprcursor  # your existing derivation
    gdshader-lsp-cpp
  ];

  home.file.".local/share/icons/XCursor-Pro-Dark-Hyprcursor".source =
    "${xcursor-pro-hyprcursor}/XCursor-Pro-Dark-Hyprcursor";
}
