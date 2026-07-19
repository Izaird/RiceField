{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gdshader-language-server";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "armsnyder";
    repo = "gdshader-language-server";
    rev = "v${version}";
    hash = "sha256-HighIuiNzqG+xpBDAf7wpn+QwjmwBWOGoOWp2cirgq4=";
  };

  vendorHash = "sha256-JozUDktYvS1vf+QWxkB0w839lP3WSvoeB+nWWC4hd7I=";

  meta = with lib; {
    description = "Language server for Godot's .gdshader files";
    homepage = "https://github.com/armsnyder/gdshader-language-server";
    license = licenses.mit;
    mainProgram = "gdshader-language-server";
  };
}
