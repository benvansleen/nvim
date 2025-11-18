-- [nfnl] fnl/lsp/on-attach.fnl
local M = require("nfnl.module").define("lsp.on-attach")
M.on_attach = function(client, bufnr)
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "",
            },
            numhl = { [vim.diagnostic.severity.ERROR] = "ErrorMsg", [vim.diagnostic.severity.WARN] = "WarningMsg" },
        },
    })
    vim.lsp.inlay_hint.enable(true, nil, bufnr)
    do
        local nvim_navic = require("nfnl.module").autoload("nvim-navic")
        nvim_navic.attach(client, bufnr)
        vim.wo["winbar"] = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end
    do
        do
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", noremap = true })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction", noremap = true })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition", noremap = true })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration", noremap = true })
            vim.keymap.set(
                "n",
                "<leader>D",
                vim.lsp.buf.type_definition,
                { desc = "Type [D]efinition", noremap = true }
            )
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", noremap = true })
            vim.keymap.set(
                "n",
                "<leader>wa",
                vim.lsp.buf.add_workspace_folder,
                { desc = "[W]orkspace [A]dd Folder", noremap = true }
            )
            vim.keymap.set(
                "n",
                "<leader>wr",
                vim.lsp.buf.remove_workspace_folder,
                { desc = "[W]orkspace [R]emove Folder", noremap = true }
            )
            local function _1_()
                return print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end
            vim.keymap.set("n", "<leader>wl", _1_, { desc = "[W]orkspace [L]ist Folders", noremap = true })
        end
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation", noremap = true })
    end
    local function _2_()
        return vim.lsp.buf.format()
    end
    vim.api.nvim_buf_create_user_command(bufnr, "Format", _2_, { desc = "Format current buffer with LSP" })
    if nixCats("general.telescope") then
        local function _3_()
            local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
            return mod_12_auto.lsp_definitions()
        end
        vim.keymap.set("n", "gd", _3_, { desc = "[G]oto [D]efinitions", noremap = true })
        local function _4_()
            local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
            return mod_12_auto.lsp_references()
        end
        vim.keymap.set("n", "gr", _4_, { desc = "[G]oto [R]eferences", noremap = true })
        local function _5_()
            local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
            return mod_12_auto.lsp_implementations()
        end
        vim.keymap.set("n", "gI", _5_, { desc = "[G]oto [I]mplementation", noremap = true })
        local function _6_()
            local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
            return mod_12_auto.lsp_document_symbols()
        end
        vim.keymap.set("n", "<leader>ds", _6_, { desc = "[D]ocument [S]ymbols", noremap = true })
        local function _7_()
            local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
            return mod_12_auto.lsp_dynamic_workspace_symbols()
        end
        return vim.keymap.set("n", "<leader>ws", _7_, { desc = "[W]orkspace [S]ymbols", noremap = true })
    else
        return nil
    end
end
return M
