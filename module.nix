inputs:
{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:

{
  imports = [ wlib.wrapperModules.neovim ];

  ## can also use an impure path; this will not be provisioned by nix -- allowing for normal quick-reload behavior
  ## `config.settings.config_directory = lib.generators.mkLuaInline "vim.fn.stdpath('config')"`
  ## `config.settings.config_directory = "/home/<user>/.config/nvim"`
  config.settings.config_directory = ./.;
  # config.settings.config_directory = lib.generators.mkLuaInline "vim.fn.stdpath('config')";
  config.settings.aliases = [
    "vi"
    "vim"
  ];

  config.package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
  config.hosts.neovide.nvim-host.enable = true;

  options.nvim-lib.neovimPlugins = lib.mkOption {
    readOnly = true;
    type = lib.types.attrsOf wlib.types.stringable;
    default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
  };

  config.specs.lze = with pkgs.vimPlugins; [
    lze
    lzextras
  ];

  config.specs.always = {
    after = [ "lze" ];
    lazy = false;
    data = with pkgs.vimPlugins; [
      gruvbox-material-nvim
      nfnl
      vim-repeat
    ];
  };

  config.specs.general = {
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

  config.specs.blink = {
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

  config.specs.treesitter = {
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

  config.specs.format = {
    after = [ "always" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      conform-nvim
    ];
  };

  config.specs.lint = {
    after = [ "always" ];
    lazy = true;
    extraPackages = with pkgs; [ typos ];
    data = with pkgs.vimPlugins; [
      nvim-lint
    ];
  };

  config.specs.git = {
    after = [ "always" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      diffview-nvim
      gitsigns-nvim
      neogit
    ];
  };

  config.specs.opencode = {
    after = [ "always" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      opencode-nvim
    ];
  };

  config.specs.lsp = {
    after = [ "always" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      nvim-navic
      symbol-usage-nvim
      tiny-inline-diagnostic-nvim
    ];
  };

  config.specs.telescope = {
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

  config.specs.terminal = {
    after = [ "always" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      toggleterm-nvim
    ];
  };

  config.specs.tmux = {
    after = [ "always" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      Navigator-nvim
    ];
  };

  config.specs.lua = {
    after = [ "always" ];
    lazy = true;
    extraPackages = with pkgs; [
      lua-language-server
      stylua
    ];
    data = [ ];
  };
  config.specs.fennel = {
    after = [ "always" ];
    lazy = true;
    extraPackages = with pkgs; [
      luaPackages.fennel
      fennel-ls
      fnlfmt
    ];
    data = [ ];
  };
  config.specs.nix = {
    after = [ "always" ];
    lazy = true;
    extraPackages = with pkgs; [
      deadnix
      nixd
      statix
    ];
    data = [ ];
  };
  config.specs.python = {
    after = [ "always" ];
    lazy = true;
    extraPackages = with pkgs; [
      ty
      ruff
    ];
    data = [ ];
  };
  config.specs.typescript = {
    after = [ "always" ];
    lazy = true;
    extraPackages = with pkgs; [ typescript-language-server ];
    data = [ ];
  };

  config.specMods =
    {
      parentSpec ? null,
      parentOpts ? null,
      parentName ? null,
      config,
      ...
    }:
    {
      options.extraPackages = lib.mkOption {
        type = lib.types.listOf wlib.types.stringable;
        default = [ ];
        description = "a extraPackages spec field to put packages to suffix to the PATH";
      };
    };
  config.extraPackages = config.specCollect (acc: v: acc ++ (v.extraPackages or [ ])) [ ];

  options.settings.cats = lib.mkOption {
    readOnly = true;
    type = lib.types.attrsOf lib.types.bool;
    default = builtins.mapAttrs (_: v: v.enable) config.specs;
  };
  options.nvim-lib.pluginsFromPrefix = lib.mkOption {
    type = lib.types.raw;
    readOnly = true;
    default =
      prefix: inputs:
      lib.pipe inputs [
        builtins.attrNames
        (builtins.filter (s: lib.hasPrefix prefix s))
        (map (
          input:
          let
            name = lib.removePrefix prefix input;
          in
          {
            inherit name;
            value = config.nvim-lib.mkPlugin name inputs.${input};
          }
        ))
        builtins.listToAttrs
      ];
  };
}
