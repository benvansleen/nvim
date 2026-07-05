inputs:
{
  config,
  lib,
  pkgs,
  ...
}:

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

    # package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
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
          oil-nvim
          nvim-highlight-colors
          nvim-surround
          opencode-nvim
          config.nvim-lib.neovimPlugins.direnv-nvim
          config.nvim-lib.neovimPlugins.foldtext-nvim
          smear-cursor-nvim
          undotree
          vim-startuptime
          which-key-nvim
        ];
      };

      blink = {
        after = [ "always" ];
        lazy = false;
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
        extraPackages = with pkgs; [
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
        lazy = false;
        extraPackages = with pkgs; [
          tree-sitter
        ];
        data = with pkgs.vimPlugins; [
          hlargs-nvim
          nvim-ts-autotag
          nvim-treesitter.withAllGrammars
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
        extraPackages = with pkgs; [ typos ];
        data = with pkgs.vimPlugins; [
          nvim-lint
        ];
      };

      git = {
        after = [ "always" ];
        lazy = true;
        data = with pkgs.vimPlugins; [
          diffview-nvim
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
        extraPackages = with pkgs; [
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
        extraPackages = with pkgs; [
          lua-language-server
          stylua
        ];
        data = [ ];
      };
      lisp = {
        after = [ "always" ];
        lazy = true;
        extraPackages = with pkgs; [
        ];
        data = with pkgs.vimPlugins; [
          nvim-parinfer
        ];
      };
      fennel = {
        after = [ "always" ];
        lazy = true;
        extraPackages = with pkgs; [
          luaPackages.fennel
          fennel-ls
          fnlfmt
        ];
        data = [ ];
      };
      nix = {
        after = [ "always" ];
        lazy = true;
        extraPackages = with pkgs; [
          deadnix
          nixd
          statix
        ];
        data = [ ];
      };
      python = {
        after = [ "always" ];
        lazy = true;
        extraPackages = with pkgs; [
          ty
          ruff
        ];
        data = [ ];
      };
      typescript = {
        after = [ "always" ];
        lazy = true;
        extraPackages = with pkgs; [ typescript-language-server ];
        data = [ ];
      };
    };
  };
}
