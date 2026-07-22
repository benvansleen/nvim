-- [nfnl] fnl/lsp/on-attach.fnl
local M = require("nfnl.module").define("lsp.on-attach")
M.on_attach = function(client, bufnr)
    if vim.b[bufnr].big_file then
        vim.diagnostic.enable(false, { bufnr = bufnr })
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
        vim.lsp.semantic_tokens.enable(false, { bufnr = bufnr })
    else
    end
    if not vim.b[bufnr].big_file and client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    else
    end
    if not vim.b[bufnr].big_file and client:supports_method("textDocument/documentSymbol") then
        local nvim_navic = require("nfnl.module").autoload("nvim-navic")
        nvim_navic.attach(client, bufnr)
        vim.wo["winbar"] = "%{%v:lua.require'nvim-navic'.get_location()%}"
    else
    end
    do
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", expr = false, noremap = true })
        vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            { desc = "[C]ode [A]ction", expr = false, noremap = true }
        )
        vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            { desc = "[G]oto [D]efinition", expr = false, noremap = true }
        )
        vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            { desc = "[G]oto [D]eclaration", expr = false, noremap = true }
        )
        vim.keymap.set(
            "n",
            "<leader>D",
            vim.lsp.buf.type_definition,
            { desc = "Type [D]efinition", expr = false, noremap = true }
        )
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", expr = false, noremap = true })
        vim.keymap.set(
            "n",
            "<leader>wa",
            vim.lsp.buf.add_workspace_folder,
            { desc = "[W]orkspace [A]dd Folder", expr = false, noremap = true }
        )
        vim.keymap.set(
            "n",
            "<leader>wr",
            vim.lsp.buf.remove_workspace_folder,
            { desc = "[W]orkspace [R]emove Folder", expr = false, noremap = true }
        )
        local function _4_()
            return print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end
        vim.keymap.set("n", "<leader>wl", _4_, { desc = "[W]orkspace [L]ist Folders", expr = false, noremap = true })
    end
    return vim.keymap.set(
        "i",
        "<C-k>",
        vim.lsp.buf.signature_help,
        { desc = "Signature Documentation", expr = false, noremap = true }
    )
end
return M
