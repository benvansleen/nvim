require("nixCatsUtils.catPacker").setup({
    { "BirdeeHub/lze" },
    { "BirdeeHub/lzextras" },
    { "stevearc/oil.nvim" },
    { "joshdick/onedark.vim" },
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lua/plenary.nvim" },
    { "tpope/vim-repeat" },
    { "f4z3r/gruvbox-material.nvim" },

    { "OXY2DEV/helpview.nvim", opt = true },

    { "folke/flash.nvim", opt = true },
    { "gpanders/nvim-parinfer", opt = true },
    { "numToStr/Navigator.nvim", opt = true },
    { "sphamba/smear-cursor.nvim", opt = true },
    { "brenoprata10/nvim-highlight-colors", opt = true },
    { "nvim-focus/focus.nvim", opt = true },
    { "nvimdev/dashboard-nvim" },

    { "m-demare/hlargs.nvim", opt = true },
    { "RRethy/nvim-treesitter-textsubjects", opt = true },
    { "nvim-treesitter/nvim-treesitter-textobjects", opt = true },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opt = true },

    { "jvgrootveld/telescope-zoxide", opt = true },
    { "jonarrien/telescope-cmdline.nvim", opt = true, as = "telescope-cmdline-nvim" },
    { "fdschmidt93/telescope-egrepify.nvim", opt = true, as = "telescope-egrepify-nvim" },
    { "nvim-telescope/telescope-file-browser.nvim", opt = true },
    { "nvim-telescope/telescope-fzf-native.nvim", build = ":!which make && make", opt = true },
    { "natecraddock/telescope-zf-native.nvim", opt = true },
    { "nvim-telescope/telescope-ui-select.nvim", opt = true },
    { "nvim-telescope/telescope.nvim", opt = true },

    { "akinsho/toggleterm.nvim", opt = true },
    { "NotAShelf/direnv.nvim", opt = true, as = "direnv-nvim" },

    { "OXY2DEV/foldtext.nvim", opt = true, as = "foldtext-nvim" },
    { "windwp/nvim-autopairs", opt = true },

    -- lsp
    { "williamboman/mason.nvim", opt = true },
    { "williamboman/mason-lspconfig.nvim", opt = true },
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
    { "nvim-neotest/nvim-nio", opt = true },
    { "LiadOz/nvim-dap-repl-highlights", opt = true },
    { "igorlfs/nvim-dap-view", opt = true },
    { "mfussenegger/nvim-dap-python", opt = true },
    { "theHamsta/nvim-dap-virtual-text", opt = true },
    { "jay-babu/mason-nvim-dap.nvim", opt = true },
    { "mfussenegger/nvim-dap", opt = true },

    { "mbbill/undotree", opt = true },
    { "folke/which-key.nvim", opt = true },
    { "lewis6991/gitsigns.nvim", opt = true },
    { "NeogitOrg/neogit", opt = true },
    { "lukas-reineke/indent-blankline.nvim", opt = true },
    { "numToStr/Comment.nvim", opt = true, as = "comment.nvim" },
    { "kylechui/nvim-surround", opt = true },
    { "monaqa/dial.nvim", opt = true },

    { "dstein64/vim-startuptime", opt = true },
})
