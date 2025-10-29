-- [nfnl] fnl/plugins/treesitter.fnl
local function _1_(_)
    local ts = require("nvim-treesitter.configs")
    return ts.setup({
        highlight = { enable = true },
        indent = { enable = false },
        incremental_selection = { enable = true, keymaps = {} },
        textobjects = {
            select = {
                lookahead = true,
                keymaps = {
                    aa = "@parameter.outer",
                    ia = "@parameter.inner",
                    af = "@function.outer",
                    ["if"] = "@function.inner",
                    ac = "@class.outer",
                    ic = "@class.inner",
                },
                enable = false,
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
    return vim.cmd.packadd("nvim-treesitter-textobjects")
end
return { "nvim-treesitter", after = _1_, event = "DeferredUIEnter", for_cat = "general.treesitter", load = _2_ }
