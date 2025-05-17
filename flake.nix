{
  description = "lizzy: a customizable Waybar media‑playback module";

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
              "A customizable Waybar module for media playback via DBus MPRIS";
            license = licenses.mit;
            platforms = platforms.unix;
          };
        };
      in {
        packages = { lizzy = lizzyPkg; };

        defaultPackage = lizzyPkg;

        apps = {
          lizzy = {
            type = "app";
            program = "${lizzyPkg}/bin/lizzy";
          };
        };
      });
}
