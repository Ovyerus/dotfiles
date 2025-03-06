{
  buildGoModule,
  fetchFromGitHub,
}: let
  version = "0.0.2";
in
  buildGoModule {
    pname = "iconifydl";
    inherit version;

    src = fetchFromGitHub {
      owner = "ksckaan1";
      repo = "iconifydl";
      rev = "v${version}";
      hash = "sha256-mSeHKv/JGrasxng6J3u5WkSk/ll1oucC2ZSN+9CYg7E=";
    };
    vendorHash = "sha256-0ZuhzB9HAoA3ZGJY98otaMKI+VhFPbHXlco49gwmb9o=";
  }
