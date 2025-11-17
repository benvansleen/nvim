require("nixCatsUtils.catPacker").setup({
    { "Olical/nfnl" },

    { "BirdeeHub/lze" },
    { "BirdeeHub/lzextras" },
    { "nvim-lua/plenary.nvim" },

    { "f4z3r/gruvbox-material.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "nvimdev/dashboard-nvim" },
    { "sphamba/smear-cursor.nvim", opt = true },
    { "brenoprata10/nvim-highlight-colors", opt = true },

    -- general editor
    { "tpope/vim-repeat" },
    { "folke/flash.nvim", opt = true },
    { "gpanders/nvim-parinfer", opt = true },
    { "OXY2DEV/foldtext.nvim", opt = true, as = "foldtext-nvim" },
    { "windwp/nvim-autopairs", opt = true },
    { "nvim-mini/mini.indentscope", opt = true },
    { "numToStr/Comment.nvim", opt = true, as = "comment.nvim" },
    { "kylechui/nvim-surround", opt = true },
    { "monaqa/dial.nvim", opt = true },

    -- splits & navigation
    { "numToStr/Navigator.nvim", opt = true },
    { "nvim-focus/focus.nvim", opt = true },

    -- treesitter
    { "m-demare/hlargs.nvim", opt = true },
    { "RRethy/nvim-treesitter-textsubjects", opt = true },
    { "nvim-treesitter/nvim-treesitter-textobjects", opt = true },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opt = true },

    -- telescope
    { "jvgrootveld/telescope-zoxide", opt = true },
    { "jonarrien/telescope-cmdline.nvim", opt = true, as = "telescope-cmdline-nvim" },
    { "fdschmidt93/telescope-egrepify.nvim", opt = true, as = "telescope-egrepify-nvim" },
    { "nvim-telescope/telescope-file-browser.nvim", opt = true },
    { "nvim-telescope/telescope-fzf-native.nvim", build = ":!which make && make", opt = true },
    { "nvim-telescope/telescope-ui-select.nvim", opt = true },
    { "nvim-telescope/telescope.nvim", opt = true },

    { "akinsho/toggleterm.nvim", opt = true },
    { "actionshrimp/direnv.nvim", opt = true, as = "direnv-nvim" },
    { "DrKJeff16/project.nvim", opt = true },
    { "stevearc/oil.nvim", opt = true },

    -- lsp
    { "j-hui/fidget.nvim", opt = true },
    { "SmiteshP/nvim-navic", opt = true },
    { "neovim/nvim-lspconfig", opt = true },
    { "Wansmer/symbol-usage.nvim", opt = true },

    { "folke/lazydev.nvim", opt = true },

    -- completion
    { "Saghen/blink.cmp", opt = true },
    { "Saghen/blink.compat", opt = true },
    { "mikavilpas/blink-ripgrep.nvim", opt = true },
    { "xzbdmw/colorful-menu.nvim", opt = true },

    -- lint and format
    { "mfussenegger/nvim-lint", opt = true },
    { "stevearc/conform.nvim", opt = true },

    -- dap
    { "LiadOz/nvim-dap-repl-highlights", opt = true },
    { "igorlfs/nvim-dap-view", opt = true },
    { "mfussenegger/nvim-dap-python", opt = true },
    { "theHamsta/nvim-dap-virtual-text", opt = true },
    { "mfussenegger/nvim-dap", opt = true },

    -- git
    { "lewis6991/gitsigns.nvim", opt = true },
    { "NeogitOrg/neogit", opt = true },
    { "sindrets/diffview.nvim", opt = true },

    { "mbbill/undotree", opt = true },
    { "folke/which-key.nvim", opt = true },
    { "dstein64/vim-startuptime", opt = true },
})
