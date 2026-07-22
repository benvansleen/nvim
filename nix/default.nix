inputs:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  patchedRefer = config.nvim-lib.neovimPlugins.refer-nvim.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./patches/refer-find-file.patch
      ./patches/refer-hide-count.patch
    ];
  });

  lisetteTreesitterGrammar = pkgs.tree-sitter.buildGrammar {
    language = "lisette";
    version = "0.1.0";
    src = inputs."plugins-lisette-nvim" + "/editors/tree-sitter-lisette";
    generate = false;
  };
in
{
  imports = [
    (lib.modules.importApply ./nix-wrapper-modules-setup.nix inputs)
  ];

  options.settings = {
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
    hosts.neovide.nvim-host.enable = true;
    hosts.neogit.nvim-host = {
      enable = true;
      package = config.wrapperPaths.placeholder;
      addFlag = [
        "--cmd"
        "let g:neogit_host = v:true"
        "+Neogit"
      ];
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
          oil-nvim
          opencode-nvim
          config.nvim-lib.neovimPlugins.direnv-nvim
          config.nvim-lib.neovimPlugins.foldtext-nvim
          config.nvim-lib.neovimPlugins.hbac-nvim
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
          (nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars ++ [ lisetteTreesitterGrammar ]))
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
          octo-nvim
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
          lisette
        ];
        data = [
          config.nvim-lib.neovimPlugins.lisette-nvim
        ];
      };

      telescope = {
        after = [ "always" ];
        lazy = true;
        data = with pkgs.vimPlugins; [
          config.nvim-lib.neovimPlugins.telescope-cmdline-nvim
          config.nvim-lib.neovimPlugins.telescope-egrepify-nvim
          patchedRefer
          project-nvim
          telescope-nvim
          telescope-file-browser-nvim
          telescope-fzf-native-nvim
          telescope-nvim
          telescope-ui-select-nvim
          telescope-undo-nvim
          telescope-zf-native-nvim
          telescope-zoxide

          legendary-nvim
        ];
        runtimePkgs = with pkgs; [
          fd
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
          helm-ls
        ];
        data = [ ];
      };
      rust = {
        after = [ "always" ];
        lazy = true;
        runtimePkgs = with pkgs; [ rust-analyzer ];
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
        ];
        data = [ ];
      };
      terraform = {
        after = [ "always" ];
        lazy = true;
        runtimePkgs = with pkgs; [ terraform-ls ];
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
          svelte-language-server
          typescript-language-server
        ];
        data = [ ];
      };
    };
  };
}
