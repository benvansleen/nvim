-- [nfnl] fnl/config.fnl
do
    local lze = require("lze")
    local lzUtils = require("nixCatsUtils.lzUtils")
    local lzextras = require("lzextras")
    lze.register_handlers(lzUtils.for_cat)
    lze.register_handlers(lzextras.lsp)
end
do
    local numbertoggle_g = vim.api.nvim_create_augroup("numbertoggle", {})
    local highlight_g = vim.api.nvim_create_augroup("highlight", {})
    local screen_width = vim.api.nvim_win_get_width(0)
    local statuscolumn = "  %l%s%C"
    local statuscolumn_wide = (string.rep(" ", ((screen_width - 100) / 3)) .. statuscolumn)
    vim.diagnostic.config({ virtual_lines = true })
    vim.g["mapleader"] = " "
    vim.g["maplocalleader"] = " "
    vim.g["netrw_liststyle"] = 0
    vim.g["netrw_banner"] = 0
    vim.g["my_center_buffer"] = false
    do
        local _ = { nil, nil, nil, nil, nil }
    end
    do
        local _ = { require("myLuaConf.plugins"), require("myLuaConf.LSPs"), require("plugins") }
    end
    vim.opt["autoindent"] = true
    vim.opt["breakindent"] = true
    vim.opt["clipboard"] = "unnamedplus"
    vim.opt["expandtab"] = true
    vim.opt["fillchars"] = { eob = " " }
    vim.opt["hlsearch"] = true
    vim.opt["inccommand"] = "split"
    vim.opt["laststatus"] = 0
    vim.opt["list"] = true
    vim.opt["listchars"] = { tab = "\194\187 ", trail = "\194\183", nbsp = "\226\144\163" }
    vim.opt["mouse"] = "a"
    vim.opt["scrolloff"] = 10
    vim.opt["shiftround"] = true
    vim.opt["shiftwidth"] = 4
    vim.opt["signcolumn"] = "yes"
    vim.opt["smartcase"] = true
    vim.opt["softtabstop"] = -1
    vim.opt["statuscolumn"] = statuscolumn
    vim.opt["statusline"] = "%{repeat('\226\148\128',winwidth('.'))}"
    vim.opt["tabstop"] = 4
    vim.opt["termguicolors"] = true
    vim.opt["timeoutlen"] = 300
    vim.opt["updatetime"] = 250
    vim.opt["undofile"] = true
    vim.opt["number"] = false
    vim.opt["relativenumber"] = false
    vim.opt["ruler"] = false
    vim.opt["showcmd"] = false
    vim.opt["showmode"] = false
    do
        local _ = {
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
        }
    end
    local function _1_()
        local cur = vim.wo.nu
        vim.wo.number = not cur
        vim.wo.relativenumber = not cur
        return nil
    end
    local function _2_()
        vim.g.my_center_buffer = not vim.g.my_center_buffer
        return nil
    end
    local function _3_()
        local vt = vim.diagnostic.config().virtual_lines
        return vim.diagnostic.config({ virtual_lines = not vt })
    end
    local function _4_()
        return print(vim.api.nvim_buf_get_name(0))
    end
    local function _5_()
        return vim.api.nvim_buf_delete(0, {})
    end
    do
        local _ = {
            vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>"),
            vim.keymap.set("n", "<C-j>", "<C-d>zz"),
            vim.keymap.set("n", "<C-k>", "<C-u>zz"),
            vim.keymap.set("n", "<leader>tn", _1_),
            vim.keymap.set("n", "<leader>tc", _2_),
            vim.keymap.set("n", "<leader>te", _3_),
            vim.keymap.set("n", "<leader>wtf", _4_),
            vim.keymap.set("n", "<leader>q", _5_),
        }
    end
    do
        local _ = { vim.keymap.set("i", "jj", "<ESC>") }
    end
    do
        local _ = { vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv"), vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv") }
    end
    local function _6_()
        return vim.highlight.on_yank()
    end
    local function _7_()
        local winwidth = vim.api.nvim_win_get_width(0)
        if vim.g.my_center_buffer and (winwidth > (screen_width / 3)) then
            vim.wo.statuscolumn = statuscolumn_wide
            return nil
        else
            vim.wo.statuscolumn = statuscolumn
            return nil
        end
    end
    local function _9_()
        if vim.wo.nu and ("i" ~= vim.api.nvim_get_mode().mode) then
            vim.wo.relativenumber = true
            return nil
        else
            return nil
        end
    end
    local function _11_()
        if vim.wo.nu then
            vim.wo.relativenumber = false
            return nil
        else
            return nil
        end
    end
    do
        local _ = {
            vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
                desc = "return cursor to where it was last time file was closed",
                pattern = "*",
                command = 'silent! normal! g`"zv',
            }),
            vim.api.nvim_create_autocmd({ "TextYankPost" }, { group = highlight_g, pattern = "*", callback = _6_ }),
            vim.api.nvim_create_autocmd(
                { "BufEnter", "BufWinEnter", "BufWinLeave", "WinEnter", "WinLeave", "WinResized", "VimResized" },
                { callback = _7_ }
            ),
            vim.api.nvim_create_autocmd(
                { "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" },
                { pattern = "*", group = numbertoggle_g, callback = _9_, nested = false, once = false }
            ),
            vim.api.nvim_create_autocmd(
                { "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" },
                { pattern = "*", group = numbertoggle_g, callback = _11_, nested = false, once = false }
            ),
        }
    end
end
if nixCats("debug") then
    require("myLuaConf.debug")
else
end
if nixCats("lint") then
    require("myLuaConf.lint")
else
end
if nixCats("format") then
    return require("format")
else
    return nil
end
