-- [nfnl] fnl/lsp/on_attach.fnl
local function _1_(_, bufnr)
    vim.lsp.inlay_hint.enable(true, nil, bufnr)
    local function map(mode, keys, func, desc)
        local _2_
        if desc then
            _2_ = ("LSP: " .. desc)
        else
            _2_ = ""
        end
        return vim.keymap.set(mode, keys, func, { buffer = bufnr, noremap = true, desc = _2_ })
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
    local function _4_()
        return print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end
    nmap("<leader>wl", _4_, "[W]orkspace [L]ist Folders")
    local function _5_(_0)
        return vim.lsp.buf.format()
    end
    vim.api.nvim_buf_create_user_command(bufnr, "Format", _5_, { desc = "Format current buffer with LSP" })
    if nixCats("general.telescope") then
        local function _6_()
            return require("telescope.builtin").lsp_definitions()
        end
        nmap("gd", _6_, "[G]oto [D]efinitions")
        local function _7_()
            return require("telescope.builtin").lsp_references()
        end
        nmap("gr", _7_, "[G]oto [R]eferences")
        local function _8_()
            return require("telescope.builtin").lsp_implementations()
        end
        nmap("gI", _8_, "[G]oto [I]mplementation")
        local function _9_()
            return require("telescope.builtin").lsp_document_symbols()
        end
        nmap("<leader>ds", _9_, "[D]ocument [S]ymbols")
        local function _10_()
            return require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end
        return nmap("<leader>ws", _10_, "[W]orkspace [S]ymbols")
    else
        return nil
    end
end
return _1_
