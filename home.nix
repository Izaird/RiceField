{ config, pkgs, ... }:

let
  xcursor-pro-hyprcursor = pkgs.fetchFromGitHub {
    owner = "4lrick";
    repo = "XCursor-Pro-Hyprcursor";
    rev = "5cefd976fda4e187c5daf249e8da261659c8518c";
    hash = "sha256-OCARYM03MW4Y9tvKJPV2u5VJbR7eJ2KPP0IMuGae3fs=";
  };
in

{
	home.username = "izaird";
	home.homeDirectory = "/home/izaird";
	home.stateVersion = "26.05";
	programs.zsh = {
		enable = true;
		shellAliases = {
			btw = "echo I use Hyprland BTW";
		};
	};

  # programs.neovim = {
  #   enable = true;
  #   plugins = [
  #     pkgs.vimPlugins.nvim-treesitter
  #   ];
  # };

	home.file.".config/hypr".source = ./config/hypr;


  home.packages = with pkgs; [
    hyprcursor
    xcursor-pro-hyprcursor  # your existing derivation
  ];

  home.file.".local/share/icons/XCursor-Pro-Dark-Hyprcursor".source =
    "${xcursor-pro-hyprcursor}/XCursor-Pro-Dark-Hyprcursor";
}
