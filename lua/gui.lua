-- [nfnl] fnl/gui.fnl
if vim.g.neovide then
    do
        vim.g["neovide_scroll_animation_length"] = 0.1
        vim.g["neovide_cursor_trail_size"] = 0.5
        vim.g["terminal_color_0"] = "#1d2021"
        vim.g["terminal_color_1"] = "#ea6962"
        vim.g["terminal_color_2"] = "#a9b665"
        vim.g["terminal_color_3"] = "#e78a4e"
        vim.g["terminal_color_4"] = "#7daea3"
        vim.g["terminal_color_5"] = "#d3869b"
        vim.g["terminal_color_6"] = "#89b482"
        vim.g["terminal_color_7"] = "#c7a07a"
        vim.g["terminal_color_8"] = "#665c54"
        vim.g["terminal_color_9"] = "#ea6962"
        vim.g["terminal_color_10"] = "#a9b665"
        vim.g["terminal_color_11"] = "#d8a657"
        vim.g["terminal_color_12"] = "#7daea3"
        vim.g["terminal_color_13"] = "#d3869b"
        vim.g["terminal_color_14"] = "#89b482"
        vim.g["terminal_color_15"] = "#d4be98"
    end
    do
        vim.opt["guifont"] = "VictorMono Nerd Font Mono:h13"
        vim.opt["shell"] = "nu"
        vim.opt["termguicolors"] = false
    end
    local function _1_()
        local mod_12_auto = require("nfnl.module").autoload("Navigator")
        return mod_12_auto.up()
    end
    vim.keymap.set({ "n", "t" }, "<D-k>", _1_, { desc = "Navigate up", expr = false, noremap = true })
    local function _2_()
        local mod_12_auto = require("nfnl.module").autoload("Navigator")
        return mod_12_auto.down()
    end
    vim.keymap.set({ "n", "t" }, "<D-j>", _2_, { desc = "Navigate down", expr = false, noremap = true })
    local function _3_()
        local mod_12_auto = require("nfnl.module").autoload("Navigator")
        return mod_12_auto.left()
    end
    vim.keymap.set({ "n", "t" }, "<D-h>", _3_, { desc = "Navigate left", expr = false, noremap = true })
    local function _4_()
        local mod_12_auto = require("nfnl.module").autoload("Navigator")
        return mod_12_auto.right()
    end
    vim.keymap.set({ "n", "t" }, "<D-l>", _4_, { desc = "Navigate right", expr = false, noremap = true })
    local function _5_()
        local mod_12_auto = require("nfnl.module").autoload("toggleterm")
        return mod_12_auto.toggle_command()
    end
    vim.keymap.set({ "n", "t" }, "<D-t>", _5_, { desc = "Toggle Terminal", expr = false, noremap = true })
    return vim.keymap.set({ "t" }, "<D-;>", "<A-;>", { desc = "pass <A-;> to nushell", expr = false, noremap = true })
else
    return nil
end
