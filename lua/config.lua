-- [nfnl] fnl/config.fnl
do
    local lze = require("lze")
    local lzextras = require("lzextras")
    local lzUtils = require("nixCatsUtils.lzUtils")
    lze.register_handlers(lzUtils.for_cat)
    lze.register_handlers(lzextras.lsp)
end
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
vim.opt["showtabline"] = 0
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
local function _1_()
    local vt = vim.diagnostic.config().virtual_lines
    return vim.diagnostic.config({ virtual_lines = not vt })
end
local function _2_()
    return print(vim.api.nvim_buf_get_name(0))
end
local function _3_()
    return vim.api.nvim_buf_delete(0, {})
end
local function _4_()
    return vim.highlight.on_yank()
end
do
    local _ = {
        { nil, nil, nil, nil, nil, nil },
        { require("clipboard"), require("lsp"), require("lib"), require("plugins") },
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
            nil,
        },
        {
            vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights", noremap = true }),
            vim.keymap.set("n", "<C-j>", "<C-d>zz", { desc = "Scroll down", noremap = true }),
            vim.keymap.set("n", "<C-k>", "<C-u>zz", { desc = "Scroll up", noremap = true }),
            vim.keymap.set("n", "<leader>te", _1_, { desc = "[T]oggle virtual lines", noremap = true }),
            vim.keymap.set("n", "<leader>wtf", _2_, { desc = "[W]hat's [T]his [F]ile?", noremap = true }),
            vim.keymap.set("n", "<leader>q", _3_, { desc = "[Q]uit buffer", noremap = true }),
            vim.keymap.set(
                "n",
                "<leader>huc",
                "<cmd>Inspect<CR>",
                { desc = "[H]ighlight [U]nder [C]ursor", noremap = true }
            ),
        },
        { vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert Mode", noremap = true }) },
        {
            vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down", noremap = true }),
            vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move lines up", noremap = true }),
        },
        {
            vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
                desc = "return cursor to where it was last time file was closed",
                pattern = "*",
                command = 'silent! normal! g`"zv',
            }),
            vim.api.nvim_create_autocmd(
                { "TextYankPost" },
                { group = vim.api.nvim_create_augroup("highlight", {}), pattern = "*", callback = _4_ }
            ),
        },
    }
end
if nixCats("center-buffer") then
    require("center-buffer")
else
end
if nixCats("number-toggle") then
    require("number-toggle")
else
end
if nixCats("debug") then
    require("lze").load({ { import = "plugins.debug" } })
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
local nixCatsUtils = require("nixCatsUtils")
if not nixCatsUtils.isNixCats then
    return {
        {
            vim.keymap.set("n", "<up>", "<C-u>", { desc = "Scroll Up", noremap = true }),
            vim.keymap.set("n", "<down>", "<C-d>", { desc = "Scroll Down", noremap = true }),
        },
    }
else
    return nil
end
