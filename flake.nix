{
  description =
    "A customizable Waybar module for media playback that uses DBus signals.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        src = pkgs.fetchFromGitHub {
          owner = "stefur";
          repo = "lizzy";
          rev = "main";
          sha256 = "sha256-bq1CmjMbClflzEm2MwWHzlV3XqJh/YYqe2bkcj5mF1s=";
        };

        lizzyPkg = pkgs.rustPlatform.buildRustPackage {
          pname = "lizzy";
          version = "unstable";

          src = src;
          cargoLock = { lockFile = "${src}/Cargo.lock"; };

          meta = with pkgs.lib; {
            description =
              "Lizzy is a simple and small app that lets Waybar display what song or media is playing by listening to DBus signals instead of polling.";
            homepage = "https://github.com/stefur/lizzy";
            license = licenses.mit;
            platforms = platforms.unix;
            mainProgram = "lizzy";
          };
        };
      in { packages = { default = lizzyPkg; }; });
}
