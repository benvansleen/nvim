{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    wrappers = {
      url = "github:birdeehub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "nixpkgs";
      };
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    "plugins-direnv-nvim" = {
      url = "github:actionshrimp/direnv.nvim";
      flake = false;
    };
    "plugins-foldtext-nvim" = {
      url = "github:OXY2DEV/foldtext.nvim";
      flake = false;
    };
    "plugins-hbac-nvim" = {
      url = "github:axkirillov/hbac.nvim";
      flake = false;
    };
    "plugins-lisette-nvim" = {
      url = "github:ivov/lisette";
      flake = false;
    };
    "plugins-telescope-cmdline-nvim" = {
      url = "github:jonarrien/telescope-cmdline.nvim";
      flake = false;
    };
    "plugins-telescope-egrepify-nvim" = {
      url = "github:fdschmidt93/telescope-egrepify.nvim";
      flake = false;
    };
    "plugins-refer-nvim" = {
      url = "github:juniorsundar/refer.nvim";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      wrappers,
      pre-commit-hooks,
      treefmt-nix,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      eachSystem =
        f:
        nixpkgs.lib.genAttrs lib.platforms.all (
          system:
          f {
            inherit system;
            # pkgs = nixpkgs.legacyPackages.${system};
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfreePredicate =
                pkg:
                builtins.elem (lib.getName pkg) [
                  "copilot-language-server"
                  "replace"
                ];
            };
          }
        );
      module = lib.modules.importApply ./nix inputs;
      wrapper = wrappers.lib.evalModule module;
      devWrapper = wrappers.lib.evalModules {
        modules = [
          module
          ({ lib, ... }: {
            settings.config_directory = lib.mkForce (lib.generators.mkLuaInline /* lua */ ''vim.fn.stdpath("config")'');
          })
        ];
      };
      treefmtEval = pkgs: treefmt-nix.lib.evalModule pkgs ./nix/treefmt.nix;
    in
    {
      overlays = {
        neovim = final: prev: { neovim = wrapper.config.wrap { pkgs = final; }; };
      };

      wrapperModules = {
        neovim = module;
        default = self.wrapperModules.neovim;
      };

      wrappers = {
        neovim = wrapper.config;
        default = self.wrappers.neovim;
      };

      packages = eachSystem (
        { system, pkgs }:
        {
          neovim = wrapper.config.wrap { inherit pkgs; };
          default = self.packages.${system}.neovim;
        }
      );

      nixosModules = {
        default = self.nixosModules.neovim;
        neovim = wrappers.lib.mkInstallModule {
          name = "neovim";
          value = module;
        };
      };

      homeManagerModules = {
        default = self.homeManagerModules.neovim;
        neovim = wrappers.lib.mkInstallModule {
          name = "neovim";
          value = module;
          loc = [
            "home"
            "packages"
          ];
        };
      };

      devShells = eachSystem (
        { system, pkgs }:
        let
          devNeovim = devWrapper.config.wrap { inherit pkgs; };
        in
        {
          default = pkgs.mkShell {
            packages = [ devNeovim ];
            inputsFrom = [ devNeovim ];
            buildInputs = lib.flatten [
              self.checks.${system}.pre-commit-check.enabledPackages
            ];
            inherit (self.checks.${system}.pre-commit-check) shellHook;
          };
        }
      );

      formatter = eachSystem ({ pkgs, ... }: (treefmtEval pkgs).config.build.wrapper);
      checks = eachSystem (
        { system, ... }:
        {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              check-added-large-files.enable = true;
              check-merge-conflicts.enable = true;
              deadnix.enable = false;
              detect-private-keys.enable = true;
              end-of-file-fixer.enable = true;
              ripsecrets.enable = true;
              statix.enable = false; # 7/6/26: build fails
              trim-trailing-whitespace.enable = true;
              treefmt = {
                enable = true;
                packageOverrides.treefmt = self.outputs.formatter.${system};
              };
            };
          };
        }
      );
    };
}
