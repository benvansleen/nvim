{ inputs, ... }:

{
  flake-file = {
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
      flake-file.url = "github:vic/flake-file";
    };

    outputs = /* nix */ "inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./nix)";
  };

  imports = [
    inputs.flake-file.flakeModules.dendritic
  ];
}
