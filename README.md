# Lizzy Flake

This repository provides a nix flake for Lizzy, a customizable Waybar module for media playback that uses DBus signals.

## Introduction

Lizzy is a module designed for Waybar, a customizable status bar for Wayland compositors. It leverages DBus MPRIS signals to provide media playback information and controls directly on your Waybar.

## Installation

To install Lizzy using Nix, you can add this flake to your `flake.nix`:

```nix
{
  inputs.lizzy-flake.url = "github:chikof/lizzy-flake";
}
```

Then, include it in your system configuration or user environment.

```nix
environment.systemPackages = with pkgs; [
    inputs.lizzy-flake.packages.${pkgs.system}.lizzy
];
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
