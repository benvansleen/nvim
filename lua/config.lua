-- [nfnl] fnl/config.fnl
do
    do
        vim.g["mapleader"] = " "
        vim.g["maplocalleader"] = ","
        vim.g["my_center_buffer"] = true
        vim.g["loaded_matchit"] = 1
        vim.g["netrw_liststyle"] = 0
        vim.g["netrw_banner"] = 0
        vim.g["_debug_my_center_buffer"] = false
    end
    do
        require("plugins.appearance")
        require("plugins.completion")
        require("plugins.debug")
        require("plugins.editor")
        require("plugins.format")
        require("plugins.git")
        require("plugins.lint")
        require("plugins.lisp")
        require("plugins.lisette")
        require("plugins.lsp")
        require("plugins.misc")
        require("plugins.opencode")
        require("plugins.pairs")
        require("plugins.oil")
        require("plugins.telescope")
        require("plugins.terminal")
        require("plugins.tmux")
        require("plugins.treesitter")
    end
    do
        require("clipboard")
        require("gui")
        require("lsp")
        require("statuscolumn")
        require("theme")
    end
    do
        vim.opt["autoindent"] = true
        vim.opt["autoread"] = true
        vim.opt["backupcopy"] = "yes"
        vim.opt["breakindent"] = true
        vim.opt["cursorline"] = true
        vim.opt["expandtab"] = true
        vim.opt["fillchars"] = { eob = " " }
        vim.opt["hlsearch"] = true
        vim.opt["ignorecase"] = true
        vim.opt["inccommand"] = "split"
        vim.opt["laststatus"] = 0
        vim.opt["linebreak"] = true
        vim.opt["list"] = true
        vim.opt["listchars"] = { tab = "\194\187 ", trail = "\194\183", nbsp = "\226\144\163" }
        vim.opt["mouse"] = "a"
        vim.opt["scrolloff"] = 10
        vim.opt["shiftround"] = true
        vim.opt["shiftwidth"] = 2
        vim.opt.shortmess:append("I")
        vim.opt["signcolumn"] = "yes"
        vim.opt["smartcase"] = true
        vim.opt["showtabline"] = 0
        vim.opt["softtabstop"] = -1
        vim.opt["splitbelow"] = true
        vim.opt["splitright"] = true
        vim.opt["statusline"] = "%{repeat('\226\148\128',winwidth('.'))}"
        vim.opt["tabstop"] = 2
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
        vim.keymap.set({ "n", "v" }, "<C-j>", "<C-d>zz", { desc = "Scroll up", expr = false, noremap = true })
        vim.keymap.set({ "n", "v" }, "<C-k>", "<C-u>zz", { desc = "Scroll down", expr = false, noremap = true })
    end
    do
        vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights", expr = false, noremap = true })
        local function _1_()
            return print(vim.api.nvim_buf_get_name(0))
        end
        vim.keymap.set("n", "<leader>wtf", _1_, { desc = "[W]hat's [T]his [F]ile?", expr = false, noremap = true })
        vim.keymap.set("n", "<leader>q", vim.cmd.bdelete, { desc = "[Q]uit buffer", expr = false, noremap = true })
        local function _2_()
            return vim.cmd("bdelete!")
        end
        vim.keymap.set("n", "<leader>Q", _2_, { desc = "Forcefully [Q]uit buffer", expr = false, noremap = true })
        vim.keymap.set(
            "n",
            "<leader>huc",
            "<cmd>Inspect<CR>",
            { desc = "[H]ighlight [U]nder [C]ursor", expr = false, noremap = true }
        )
        local function _3_()
            return vim.cmd.normal("gcc")
        end
        vim.keymap.set("n", "<M-/>", _3_, { desc = "Comment line", expr = false, noremap = true })
    end
    do
        vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert Mode", expr = false, noremap = true })
    end
    do
        vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down", expr = false, noremap = true })
        vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move lines up", expr = false, noremap = true })
    end
    do
        vim.keymap.set(
            "t",
            "<Esc>",
            "<C-\\><C-n>",
            { desc = "Exit Terminal Insert Mode", expr = false, noremap = true }
        )
    end
    vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
        desc = "return cursor to where it was last time file was closed",
        pattern = "*",
        command = 'silent! normal! g`"zv',
    })
    local function _4_()
        return vim.highlight.on_yank()
    end
    vim.api.nvim_create_autocmd(
        { "TextYankPost" },
        { group = vim.api.nvim_create_augroup("highlight", {}), pattern = "*", callback = _4_ }
    )
end
do
    local number_toggle = require("nfnl.module").autoload("lib.number-toggle")
    do
        vim.keymap.set(
            "n",
            "<leader>tn",
            number_toggle.toggle,
            { desc = "[T]oggle [n]umbertoggle", expr = false, noremap = true }
        )
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
if false == _G.nixInfo.isNix then
    vim.keymap.set("n", "<up>", "<C-u>", { desc = "Scroll Up", expr = false, noremap = true })
    return vim.keymap.set("n", "<down>", "<C-d>", { desc = "Scroll Down", expr = false, noremap = true })
else
    return nil
end
