-- [nfnl] fnl/config.fnl
do
    local lze = require("nfnl.module").autoload("lze")
    local lzextras = require("nfnl.module").autoload("lzextras")
    local lzUtils = require("nfnl.module").autoload("nixCatsUtils.lzUtils")
    lze.register_handlers(lzUtils.for_cat)
    lze.register_handlers(lzextras.lsp)
end
do
    do
        vim.g["mapleader"] = " "
        vim.g["maplocalleader"] = ","
        vim.g["my_center_buffer"] = true
        vim.g["netrw_liststyle"] = 0
        vim.g["netrw_banner"] = 0
        vim.g["_debug_my_center_buffer"] = false
    end
    do
        require("plugins.appearance")
        require("plugins.completion")
        require("plugins.editor")
        require("plugins.git")
        require("plugins.lisp")
        require("plugins.lsp")
        require("plugins.misc")
        require("plugins.pairs")
        require("plugins.oil")
        require("plugins.telescope")
        require("plugins.terminal")
        require("plugins.tmux")
        require("plugins.treesitter")
    end
    do
        if nixCats("debug") then
            require("plugins.debug")
        else
        end
        if nixCats("lint") then
            require("plugins.lint")
        else
        end
        if nixCats("format") then
            require("plugins.format")
        else
        end
    end
    do
        require("clipboard")
        require("lsp")
        require("statuscolumn")
        require("theme")
    end
    do
        vim.opt["autoindent"] = true
        vim.opt["breakindent"] = true
        vim.opt["cursorline"] = true
        vim.opt["expandtab"] = true
        vim.opt["fillchars"] = { eob = " " }
        vim.opt["hlsearch"] = true
        vim.opt["ignorecase"] = true
        vim.opt["inccommand"] = "split"
        vim.opt["laststatus"] = 0
        vim.opt["list"] = true
        vim.opt["listchars"] = { tab = "\194\187 ", trail = "\194\183", nbsp = "\226\144\163" }
        vim.opt["mouse"] = "a"
        vim.opt["scrolloff"] = 10
        vim.opt["shiftround"] = true
        vim.opt["shiftwidth"] = 4
        vim.opt.shortmess:append("I")
        vim.opt["signcolumn"] = "yes"
        vim.opt["smartcase"] = true
        vim.opt["showtabline"] = 0
        vim.opt["softtabstop"] = -1
        vim.opt["splitbelow"] = true
        vim.opt["splitright"] = true
        vim.opt["statusline"] = "%{repeat('\226\148\128',winwidth('.'))}"
        vim.opt["tabstop"] = 4
        vim.opt["termguicolors"] = true
        vim.opt["timeoutlen"] = 300
        vim.opt["updatetime"] = 250
        vim.opt["undofile"] = true
        vim.opt["winborder"] = "shadow"
        vim.opt["number"] = false
        vim.opt["relativenumber"] = false
        vim.opt["ruler"] = false
        vim.opt["showcmd"] = false
        vim.opt["showmode"] = false
    end
    do
        vim.keymap.set({ "n", "v" }, "<C-j>", "<C-d>zz", { desc = "Scroll up", noremap = true })
        vim.keymap.set({ "n", "v" }, "<C-k>", "<C-u>zz", { desc = "Scroll down", noremap = true })
    end
    do
        vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights", noremap = true })
        local function _4_()
            local vt = vim.diagnostic.config().virtual_lines
            return vim.diagnostic.config({ virtual_lines = not vt })
        end
        vim.keymap.set("n", "<leader>te", _4_, { desc = "[T]oggle virtual lines", noremap = true })
        local function _5_()
            return print(vim.api.nvim_buf_get_name(0))
        end
        vim.keymap.set("n", "<leader>wtf", _5_, { desc = "[W]hat's [T]his [F]ile?", noremap = true })
        local function _6_()
            local diffview = require("nfnl.module").autoload("diffview.lib")
            if diffview.get_current_view() then
                return vim.cmd.DiffviewClose()
            else
                return vim.cmd.bdelete()
            end
        end
        vim.keymap.set("n", "<leader>q", _6_, { desc = "[Q]uit buffer", noremap = true })
        local function _8_()
            return vim.cmd("bdelete!")
        end
        vim.keymap.set("n", "<leader>Q", _8_, { desc = "Forcefully [Q]uit buffer", noremap = true })
        vim.keymap.set(
            "n",
            "<leader>huc",
            "<cmd>Inspect<CR>",
            { desc = "[H]ighlight [U]nder [C]ursor", noremap = true }
        )
    end
    do
        vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert Mode", noremap = true })
    end
    do
        vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down", noremap = true })
        vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move lines up", noremap = true })
    end
    vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
        desc = "return cursor to where it was last time file was closed",
        pattern = "*",
        command = 'silent! normal! g`"zv',
    })
    local function _9_()
        return vim.highlight.on_yank()
    end
    vim.api.nvim_create_autocmd(
        { "TextYankPost" },
        { group = vim.api.nvim_create_augroup("highlight", {}), pattern = "*", callback = _9_ }
    )
end
do
    local number_toggle = require("nfnl.module").autoload("lib.number-toggle")
    do
        vim.keymap.set("n", "<leader>tn", number_toggle.toggle, { desc = "[T]oggle [n]umbertoggle", noremap = true })
    end
    vim.api.nvim_create_autocmd(
        number_toggle["autocmd-toggle-on"],
        { pattern = "*", group = number_toggle.group, callback = number_toggle["activate-relative-number"] }
    )
    vim.api.nvim_create_autocmd(
        number_toggle["autocmd-toggle-off"],
        { pattern = "*", group = number_toggle.group, callback = number_toggle["disable-relative-number"] }
    )
end
local _10_
do
    local cats_45_auto = require("nfnl.module").autoload("nixCatsUtils")
    _10_ = cats_45_auto.isNixCats
end
if false == _10_ then
    vim.keymap.set("n", "<up>", "<C-u>", { desc = "Scroll Up", noremap = true })
    return vim.keymap.set("n", "<down>", "<C-d>", { desc = "Scroll Down", noremap = true })
else
    return nil
end
