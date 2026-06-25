{ config, pkgs, ... }:

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
}
