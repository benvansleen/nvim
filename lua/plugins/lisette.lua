-- [nfnl] fnl/plugins/lisette.fnl
local _local_1_ = require("lsp.on-attach")
local on_attach = _local_1_.on_attach
vim.filetype.add({ extension = { lis = "lisette" } })
local function setup_lisette()
    local plugin_dir = _G.nixInfo.get_nix_plugin_path("lisette-nvim")
    local nvim_dir = (plugin_dir .. "/editors/nvim")
    local parser_src = (plugin_dir .. "/editors/tree-sitter-lisette/src")
    local parser_dir = (vim.fn.stdpath("data") .. "/lisette/parser")
    local parser_so = (parser_dir .. "/lisette.so")
    vim.opt.rtp:append(nvim_dir)
    local function parser_is_stale()
        if vim.fn.isdirectory(parser_src) == 0 then
            return false
        else
            local so_time = vim.fn.getftime(parser_so)
            if so_time == -1 then
                return true
            else
                local src_time = math.max(
                    vim.fn.getftime((parser_src .. "/parser.c")),
                    vim.fn.getftime((parser_src .. "/scanner.c"))
                )
                return (src_time > so_time)
            end
        end
    end
    if parser_is_stale() then
        vim.fn.mkdir(parser_dir, "p")
        local result = vim.fn.system({
            "cc",
            "-o",
            parser_so,
            "-I",
            parser_src,
            (parser_src .. "/parser.c"),
            (parser_src .. "/scanner.c"),
            "-shared",
            "-Os",
            "-fPIC",
        })
        if vim.v.shell_error ~= 0 then
            vim.notify(("Failed to compile Lisette tree-sitter parser:\n" .. result), vim.log.levels.WARN)
        else
        end
    else
    end
    if vim.fn.filereadable(parser_so) == 1 then
        vim.treesitter.language.add("lisette", { path = parser_so })
        local function start_lisette_treesitter(_6_)
            local buf = _6_.buf
            if vim.bo[buf].filetype == "lisette" then
                if pcall(vim.treesitter.start, buf, "lisette") then
                    vim.bo[buf]["indentexpr"] = "v:lua.require'nvim-treesitter'.indentexpr()"
                    return nil
                else
                    return nil
                end
            else
                return nil
            end
        end
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("UserLisetteTreesitter", { clear = true }),
            pattern = "lisette",
            callback = start_lisette_treesitter,
        })
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) then
                start_lisette_treesitter({ buf = buf })
            else
            end
        end
    else
    end
    do
        local lsp_config = dofile((nvim_dir .. "/lsp/lisette.lua"))
        lsp_config["on_attach"] = on_attach
        vim.lsp.config("lisette", lsp_config)
    end
    return vim.lsp.enable("lisette")
end
do
    local theme_42_auto = require("theme")
    vim.api.nvim_set_hl(
        0,
        "@punctuation.bracket.lisette",
        theme_42_auto["update-hl"]("@punctuation.bracket", { link = "NonText" })
    )
    vim.api.nvim_set_hl(
        0,
        "@punctuation.special.lisette",
        theme_42_auto["update-hl"]("@punctuation.special", { link = "@string" })
    )
    vim.api.nvim_set_hl(
        0,
        "@punctuation.delimiter.lisette",
        theme_42_auto["update-hl"]("@punctuation.delimiter", { link = "NonText" })
    )
    vim.api.nvim_set_hl(0, "@function.call.lisette", theme_42_auto["update-hl"]("@function.call", { italic = true }))
    vim.api.nvim_set_hl(
        0,
        "@function.method.call.lisette",
        theme_42_auto["update-hl"]("@function.method.call", { italic = true })
    )
    vim.api.nvim_set_hl(0, "@module.builtin.lisette", theme_42_auto["update-hl"]("@module.builtin", { bold = true }))
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    keymap_30_auto = mod_12_auto.keymap({ "lisette-nvim", after = setup_lisette, for_cat = "lisette", ft = "lisette" })
end
