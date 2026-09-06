{ inputs, self, ... }:

{
  flake-file.inputs = {
    wrappers = {
      url = "github:birdeehub/nix-wrapper-modules";
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
  };

  flake = {
    wrapperModules = {
      default = self.wrapperModules.neovim;
      neovim = self.modules.generic.neovim-wrapper;
    };

    wrappers = {
      default = self.wrappers.neovim;
      neovim = inputs.wrappers.lib.evalModule self.wrapperModules.neovim;
      dev = inputs.wrappers.lib.evalModules {
        modules = [
          self.wrapperModules.neovim
          ({ lib, ... }: {
            settings.config_directory = lib.mkForce (lib.generators.mkLuaInline /* lua */ ''vim.fn.stdpath("config")'');
          })
        ];
      };
    };

    nixosModules = {
      default = self.nixosModules.neovim;
      neovim = inputs.wrappers.lib.getInstallModule {
        name = "neovim";
        value = self.wrappers.neovim;
      };
    };

    homeModules = {
      default = self.homeModules.neovim;
      neovim = self.nixosModules.neovim;
    };

    modules.generic.neovim-wrapper =
      {
        config,
        options,
        pkgs,
        lib,
        wlib,
        ...
      }:
      let
        plugin = name: config.nvim-lib.mkPlugin name inputs.${"plugins-${name}"};
      in
      {
        imports = [
          wlib.wrapperModules.neovim
        ];

        options.settings = {
          cats = lib.mkOption {
            readOnly = true;
            type = lib.types.attrsOf lib.types.bool;
            default = builtins.mapAttrs (_: spec: spec.enable) config.specs;
          };
          nixdNixpkgsPath = lib.mkOption {
            type = with lib.types; nullOr str;
            default = null;
          };
          nixdNixosPath = lib.mkOption {
            type = with lib.types; nullOr str;
            default = null;
          };
          nixdHomeManagerPath = lib.mkOption {
            type = with lib.types; nullOr str;
            default = null;
          };
        };

        config = {
          specMods = _: {
            options.runtimePkgs = options.runtimePkgs // {
              description = ''
                Runtime packages to add to PATH when this spec is enabled.
              '';
            };
          };
          runtimePkgs = config.specCollect (packages: spec: packages ++ (spec.runtimePkgs or [ ])) [ ];

          hosts = {
            neovide.nvim-host.enable = true;
            neogit.nvim-host = {
              enable = true;
              package = config.wrapperPaths.placeholder;
              addFlag = [
                "--cmd"
                "let g:neogit_host = v:true"
                "+Neogit"
              ];
            };
          };
          drv.postBuild = ''
            ln -s nvim-neogit "$out/bin/neogit"
          '';

          package = pkgs.neovim-unwrapped.overrideAttrs (old: {
            # Optimize across translation units without making the binary CPU-specific.
            cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON" ];
          });
          settings = {
            ## can also use an impure path; this will not be provisioned by nix -- allowing for normal quick-reload behavior
            ## `config.settings.config_directory = lib.generators.mkLuaInline "vim.fn.stdpath('config')"`
            ## `config.settings.config_directory = "/home/<user>/.config/nvim"`
            config_directory = ../.;

            aliases = [
              "vi"
              "vim"
            ];
          };

          specs = {
            lze = with pkgs.vimPlugins; [
              lze
              lzextras
            ];

            always = {
              after = [ "lze" ];
              lazy = false;
              data = with pkgs.vimPlugins; [
                gruvbox-material-nvim
                nfnl
                vim-repeat
              ];
            };

            general = {
              after = [
                "lze"
                "always"
              ];
              lazy = true;
              data = with pkgs.vimPlugins; [
                dashboard-nvim
                dial-nvim
                fidget-nvim
                flash-nvim
                focus-nvim
                mini-ai
                mini-indentscope
                nvim-highlight-colors
                nvim-surround
                nvim-web-devicons
                oil-nvim
                opencode-nvim
                (plugin "direnv-nvim")
                (plugin "foldtext-nvim")
                (plugin "hbac-nvim")
                smear-cursor-nvim
                trouble-nvim
                undotree
                vim-startuptime
                which-key-nvim
              ];
            };

            blink = {
              after = [ "always" ];
              lazy = true;
              data = with pkgs.vimPlugins; [
                cmp-cmdline
                blink-cmp
                blink-compat
                blink-pairs
                blink-ripgrep-nvim
                colorful-menu-nvim
                copilot-lua
                sidekick-nvim
              ];
            };

            debug = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                gdb
                (python3.withPackages (pypkg: [ pypkg.debugpy ]))
              ];
              data = with pkgs.vimPlugins; [
                nvim-dap
                nvim-dap-view
                nvim-dap-virtual-text
                nvim-dap-python
              ];
            };

            treesitter = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                tree-sitter
              ];
              data = with pkgs.vimPlugins; [
                hlargs-nvim
                nvim-ts-autotag
                (nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars ++ [ pkgs.lisetteTreesitterGrammar ]))
              ];
            };

            format = {
              after = [ "always" ];
              lazy = true;
              data = with pkgs.vimPlugins; [
                conform-nvim
              ];
            };

            lint = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [ typos ];
              data = with pkgs.vimPlugins; [
                nvim-lint
              ];
            };

            git = {
              after = [ "always" ];
              lazy = true;
              data = with pkgs.vimPlugins; [
                codediff-nvim
                gitsigns-nvim
                neogit
              ];
            };

            opencode = {
              after = [ "always" ];
              lazy = true;
              data = with pkgs.vimPlugins; [
                opencode-nvim
              ];
            };

            lsp = {
              after = [ "always" ];
              lazy = true;
              data = with pkgs.vimPlugins; [
                nvim-navic
                symbol-usage-nvim
                tiny-inline-diagnostic-nvim
              ];
            };

            lisette = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                gcc
              ];
              data = with pkgs.vimPlugins; [
                lisette-nvim
              ];
            };

            telescope = {
              after = [ "always" ];
              lazy = true;
              data = with pkgs.vimPlugins; [
                refer-nvim
                project-nvim
                telescope-nvim
                telescope-fzf-native-nvim
                telescope-undo-nvim
                telescope-zf-native-nvim
                telescope-zoxide
              ];
              runtimePkgs = with pkgs; [
                fd
                ripgrep
              ];
            };

            terminal = {
              after = [ "always" ];
              lazy = true;
              data = with pkgs.vimPlugins; [
                toggleterm-nvim
              ];
            };

            tmux = {
              after = [ "always" ];
              lazy = true;
              data = with pkgs.vimPlugins; [
                Navigator-nvim
              ];
            };

            ## Language dependencies
            lua = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                lua-language-server
                stylua
              ];
              data = [ ];
            };
            lisp = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
              ];
              data = with pkgs.vimPlugins; [
                nvim-parinfer
              ];
            };
            fennel = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                luaPackages.fennel
                fennel-ls
                fnlfmt
              ];
              data = [ ];
            };
            helm = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                # helm-ls
              ];
              data = [ ];
            };
            rust = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                # cargo
                # clippy
                # rust-analyzer
                # rustc
                # rustfmt
              ];
              data = [ ];
            };
            nu = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [ nushell ];
              data = [ ];
            };
            go = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                go
                gopls
                gotools
              ];
              data = [ ];
            };
            terraform = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                # terraform
                # terraform-ls
              ];
              data = [ ];
            };
            postgres = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                # postgres-language-server
              ];
              data = [ ];
            };
            nix = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                deadnix
                nixd
                statix
              ];
              data = [ ];
            };
            python = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                ty
                ruff
              ];
              data = [ ];
            };
            typescript = {
              after = [ "always" ];
              lazy = true;
              runtimePkgs = with pkgs; [
                # svelte-language-server
                # typescript-language-server
              ];
              data = [ ];
            };
          };
        };
      };
  };
}
