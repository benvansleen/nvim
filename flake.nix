# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./nix);

  inputs = {
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    plugins-direnv-nvim = {
      url = "github:actionshrimp/direnv.nvim";
      flake = false;
    };
    plugins-foldtext-nvim = {
      url = "github:OXY2DEV/foldtext.nvim";
      flake = false;
    };
    plugins-hbac-nvim = {
      url = "github:axkirillov/hbac.nvim";
      flake = false;
    };
    plugins-lisette-nvim = {
      url = "github:ivov/lisette";
      flake = false;
    };
    plugins-refer-nvim = {
      url = "github:juniorsundar/refer.nvim";
      flake = false;
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrappers = {
      url = "github:birdeehub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
