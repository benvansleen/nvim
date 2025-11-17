-- [nfnl] fnl/lsp/on-attach.fnl
local M = require("nfnl.module").define("lsp.on-attach")
M.on_attach = function(client, bufnr)
    vim.diagnostic.config({
        virtual_lines = { current_line = true },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "",
            },
            linehl = { [vim.diagnostic.severity.ERROR] = "ErrorMsg" },
            numhl = { [vim.diagnostic.severity.WARN] = "WarningMsg" },
        },
    })
    vim.lsp.inlay_hint.enable(true, nil, bufnr)
    do
        local nvim_navic = require("nfnl.module").autoload("nvim-navic")
        nvim_navic.attach(client, bufnr)
        vim.wo.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end
    local function map(mode, keys, func, desc)
        local _1_
        if desc then
            _1_ = ("LSP: " .. desc)
        else
            _1_ = ""
        end
        return vim.keymap.set(mode, keys, func, { buffer = bufnr, noremap = true, desc = _1_ })
    end
    local function nmap(...)
        return map("n", ...)
    end
    local function imap(...)
        return map("i", ...)
    end
    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    imap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    local function _3_()
        return print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end
    nmap("<leader>wl", _3_, "[W]orkspace [L]ist Folders")
    local function _4_(_)
        return vim.lsp.buf.format()
    end
    vim.api.nvim_buf_create_user_command(bufnr, "Format", _4_, { desc = "Format current buffer with LSP" })
    if nixCats("general.telescope") then
        local function _5_()
            local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
            return mod_12_auto.lsp_definitions()
        end
        nmap("gd", _5_, "[G]oto [D]efinitions")
        local function _6_()
            local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
            return mod_12_auto.lsp_references()
        end
        nmap("gr", _6_, "[G]oto [R]eferences")
        local function _7_()
            local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
            return mod_12_auto.lsp_implementations()
        end
        nmap("gI", _7_, "[G]oto [I]mplementation")
        local function _8_()
            local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
            return mod_12_auto.lsp_document_symbols()
        end
        nmap("<leader>ds", _8_, "[D]ocument [S]ymbols")
        local function _9_()
            local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
            return mod_12_auto.lsp_dynamic_workspace_symbols()
        end
        return nmap("<leader>ws", _9_, "[W]orkspace [S]ymbols")
    else
        return nil
    end
end
return M
