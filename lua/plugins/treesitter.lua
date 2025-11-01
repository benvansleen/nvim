-- [nfnl] fnl/plugins/treesitter.fnl
local function _1_()
    local p_7_auto = require("nvim-treesitter.configs")
    return p_7_auto.setup({
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = false },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
        textsubjects = {
            enable = true,
            prev_selection = ",",
            keymaps = {
                ["."] = "textsubjects-smart",
                [";"] = "textsubjects-container-outer",
                ["i;"] = "textsubjects-container-inner",
            },
        },
        textobjects = {
            select = {
                enable = true,
                disable = { "fennel" },
                lookahead = true,
                keymaps = {
                    aa = "@parameter.outer",
                    ia = "@parameter.inner",
                    af = "@function.outer",
                    ["if"] = "@function.inner",
                    ac = "@class.outer",
                    ic = "@class.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
                goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
                goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
                goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
            },
            swap = {
                enable = true,
                swap_next = { ["<leader>a"] = "@parameter.inner" },
                swap_previous = { ["<leader>A"] = "@parameter.inner" },
            },
        },
    })
end
local function _2_(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd("nvim-treesitter-textobjects")
    vim.cmd.packadd("nvim-treesitter-textsubjects")
    vim.wo.foldlevel = 10
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    return nil
end
local function _3_()
    local p_8_auto = require("hlargs")
    return p_8_auto.setup()
end
return {
    { "nvim-treesitter", after = _1_, event = "DeferredUIEnter", for_cat = "general.treesitter", load = _2_ },
    { "hlargs.nvim", after = _3_, event = "DeferredUIEnter", for_cat = "general.treesitter" },
}
