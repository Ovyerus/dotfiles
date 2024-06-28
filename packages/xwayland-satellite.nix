{
  clang,
  lib,
  fetchFromGitHub,
  makeWrapper,
  pkg-config,
  rustPlatform,
  xcb-util-cursor,
  xorg,
  xwayland,
}:
rustPlatform.buildRustPackage rec {
  pname = "xwayland-satellite";
  version = "v0.4";

  src = fetchFromGitHub {
    owner = "Supreeeme";
    repo = pname;
    rev = version;
    hash = "sha256-dwF9nI54a6Fo9XU5s4qmvMXSgCid3YQVGxch00qEMvI=";
  };
  cargoHash = "sha256-Nh5ssclAqZFOBDJtEjBRs2z1l/FIVZgvBr1lxjoVjG4=";

  nativeBuildInputs = [clang pkg-config rustPlatform.bindgenHook xorg.libxcb makeWrapper];
  buildInputs = [xwayland xcb-util-cursor];

  doCheck = false; # xwayland-satellite fails checks due to not being wrapped at this point...

  postInstall = ''
    wrapProgram $out/bin/xwayland-satellite --suffix PATH : ${lib.makeBinPath [xwayland]}
  '';

  meta = {
    description = "Xwayland outside your Wayland ";
    homepage = "https://github.com/Supreeeme/xwayland-satellite";
    license = lib.licenses.mpl20;
    maintainers = [];
  };
}
