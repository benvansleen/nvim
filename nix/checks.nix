{ inputs, ... }:

{
  flake-file.inputs = {
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  perSystem = { self', system, ... }: {
    checks = {
      pre-commit-check = inputs.git-hooks.lib.${system}.run {
        src = inputs.gitignore.lib.gitignoreSource ../.;
        hooks = {
          check-added-large-files.enable = true;
          check-merge-conflicts.enable = true;
          deadnix.enable = false;
          detect-private-keys.enable = true;
          end-of-file-fixer.enable = true;
          ripsecrets.enable = true;
          statix.enable = true;
          trim-trailing-whitespace.enable = true;
          treefmt = {
            enable = true;
            packageOverrides.treefmt = self'.formatter;
          };
        };
      };
    };
  };
}
