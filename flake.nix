{
  description = "Tmux script to open several panes, run a command in them all and synchronizing the exit";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        packages = rec {
          default = tmux-web;
          tmux-web =
            (pkgs.writeScriptBin "tmux-web"
              (builtins.readFile ./tmux-web))
            .overrideAttrs (old: {
              buildCommand = "${old.buildCommand}\n patchShebangs $out";
            });
        };
      }
    );
}
