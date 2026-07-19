{ lib, stdenv, fetchFromGitHub, cmake, scons, python3 }:

stdenv.mkDerivation (finalAttrs: {
  pname = "gdshader-lsp-cpp";
  version = "0.2.5.1";

  src = fetchFromGitHub {
    owner = "scump1";
    repo = "gdshader-lsp-cpp";
    rev = "v${finalAttrs.version}";
    fetchSubmodules = true;
    hash = "sha256-K+L8Hj7RcweLfR1k0rF2Tc0rgZOYyAQw+0cs7tHaVO8=";
  };

  nativeBuildInputs = [ cmake scons python3 ];

  dontConfigure = true; # <-- skip cmake's auto configurePhase; we drive both
                        #     cmake and scons manually below

  buildPhase = ''
    runHook preBuild

    cmake -B extern/lsp-framework/build_linux -S extern/lsp-framework \
      -DCMAKE_BUILD_TYPE=Release
    cmake --build extern/lsp-framework/build_linux -j "$NIX_BUILD_CORES"

    scons platform=linux target=release -j "$NIX_BUILD_CORES"

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 bin/linux/release/gdshader_lsp_release_linux \
      $out/bin/gdshader-lsp-cpp
    runHook postInstall
  '';

  meta = with lib; {
    description = "C++ native LSP for Godot's GDShader shading language";
    homepage = "https://github.com/scump1/gdshader-lsp-cpp";
    license = licenses.mit;
    mainProgram = "gdshader-lsp-cpp";
    platforms = platforms.linux;
  };
})
