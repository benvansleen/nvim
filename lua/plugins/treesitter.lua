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
    vim.wo.foldlevel = 10
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    return nil
end
return { "nvim-treesitter", after = _1_, event = "DeferredUIEnter", for_cat = "general.treesitter", load = _2_ }
