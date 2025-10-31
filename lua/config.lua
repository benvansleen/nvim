-- [nfnl] fnl/config.fnl
do
    local lze = require("lze")
    local lzextras = require("lzextras")
    local lzUtils = require("nixCatsUtils.lzUtils")
    lze.register_handlers(lzUtils.for_cat)
    lze.register_handlers(lzextras.lsp)
end
vim.opt["clipboard"] = ""
do
    local _ = { { nil } }
end
local function _1_()
    vim.opt["clipboard"] = "unnamedplus"
    return { { nil } }
end
vim.schedule(_1_)
do
    local numbertoggle_g = vim.api.nvim_create_augroup("numbertoggle", {})
    local highlight_g = vim.api.nvim_create_augroup("highlight", {})
    vim.g["mapleader"] = " "
    vim.g["maplocalleader"] = " "
    vim.g["my_center_buffer"] = true
    vim.g["netrw_liststyle"] = 0
    vim.g["netrw_banner"] = 0
    vim.g["_debug_my_center_buffer"] = false
    vim.opt["autoindent"] = true
    vim.opt["breakindent"] = true
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
    vim.opt["splitbelow"] = true
    vim.opt["splitright"] = true
    vim.opt["statuscolumn"] = "  %l%s%C"
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
    local function _2_()
        local cur = vim.wo.nu
        vim.wo.number = not cur
        vim.wo.relativenumber = not cur
        return nil
    end
    local function _3_()
        vim.g.my_center_buffer = not vim.g.my_center_buffer
        return nil
    end
    local function _4_()
        local vt = vim.diagnostic.config().virtual_lines
        return vim.diagnostic.config({ virtual_lines = not vt })
    end
    local function _5_()
        return print(vim.api.nvim_buf_get_name(0))
    end
    local function _6_()
        return vim.api.nvim_buf_delete(0, {})
    end
    local function _7_()
        return print(vim.inspect(vim.treesitter.get_captures_at_cursor(0)))
    end
    local function _8_()
        return vim.highlight.on_yank()
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
            { nil, nil, nil, nil, nil, nil },
            { require("lsp"), require("plugins") },
            {
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
                nil,
            },
            {
                vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true }),
                vim.keymap.set("n", "<C-j>", "<C-d>zz", { noremap = true }),
                vim.keymap.set("n", "<C-k>", "<C-u>zz", { noremap = true }),
                vim.keymap.set("n", "<leader>tn", _2_, { noremap = true }),
                vim.keymap.set("n", "<leader>tc", _3_, { noremap = true }),
                vim.keymap.set("n", "<leader>te", _4_, { noremap = true }),
                vim.keymap.set("n", "<leader>wtf", _5_, { noremap = true }),
                vim.keymap.set("n", "<leader>q", _6_, { noremap = true }),
                vim.keymap.set("n", "<leader>huc", _7_, { noremap = true }),
            },
            { vim.keymap.set("i", "jj", "<ESC>", { noremap = true }) },
            {
                vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true }),
                vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { noremap = true }),
            },
            {
                vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
                    desc = "return cursor to where it was last time file was closed",
                    pattern = "*",
                    command = 'silent! normal! g`"zv',
                }),
                vim.api.nvim_create_autocmd({ "TextYankPost" }, { group = highlight_g, pattern = "*", callback = _8_ }),
                vim.api.nvim_create_autocmd(
                    { "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" },
                    { pattern = "*", group = numbertoggle_g, callback = _9_, nested = false, once = false }
                ),
                vim.api.nvim_create_autocmd(
                    { "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" },
                    { pattern = "*", group = numbertoggle_g, callback = _11_, nested = false, once = false }
                ),
            },
        }
    end
end
if nixCats("center-buffer") then
    require("center-buffer")
else
end
if nixCats("debug") then
    require("debug")
else
end
if nixCats("lint") then
    require("lint")
else
end
if nixCats("format") then
    require("format")
else
end
local cats = require("nixCatsUtils")
if not cats.isNixCats then
    return {
        {
            vim.keymap.set("n", "<up>", "<C-u>", { noremap = true }),
            vim.keymap.set("n", "<down>", "<C-d>", { noremap = true }),
        },
    }
else
    return nil
end
