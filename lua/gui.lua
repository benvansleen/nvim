-- [nfnl] fnl/gui.fnl
if vim.g.neovide then
    do
        vim.g["neovide_scroll_animation_length"] = 0.1
        vim.g["neovide_cursor_trail_size"] = 0.5
        vim.g["terminal_color_0"] = "#202020"
        vim.g["terminal_color_1"] = "#ea6962"
        vim.g["terminal_color_2"] = "#e78a4e"
        vim.g["terminal_color_3"] = "#d8a657"
        vim.g["terminal_color_4"] = "#a9b665"
        vim.g["terminal_color_5"] = "#89b482"
        vim.g["terminal_color_6"] = "#7daea3"
        vim.g["terminal_color_7"] = "#bdae93"
        vim.g["terminal_color_8"] = "#bd6f3e"
        vim.g["terminal_color_9"] = "#e78a4e"
        vim.g["terminal_color_10"] = "#504945"
        vim.g["terminal_color_11"] = "#5a524c"
        vim.g["terminal_color_12"] = "#d3869b"
        vim.g["terminal_color_13"] = "#ddc7a1"
        vim.g["terminal_color_14"] = "#ebdbb2"
        vim.g["terminal_color_15"] = "#fbf1c7"
    end
    vim.opt["guifont"] = "VictorMono Nerd Font Mono:h13"
    vim.opt["termguicolors"] = false
    return nil
else
    return nil
end
