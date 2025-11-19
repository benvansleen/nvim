(import-macros {: cfg} :macros)

(when vim.g.neovide
  (cfg (g {neovide_scroll_animation_length 0.1
           neovide_cursor_trail_size 0.5
           terminal_color_0 "#202020"
           terminal_color_1 "#ea6962"
           terminal_color_2 "#e78a4e"
           terminal_color_3 "#d8a657"
           terminal_color_4 "#a9b665"
           terminal_color_5 "#89b482"
           terminal_color_6 "#7daea3"
           terminal_color_7 "#bdae93"
           terminal_color_8 "#bd6f3e"
           terminal_color_9 "#e78a4e"
           terminal_color_10 "#504945"
           terminal_color_11 "#5a524c"
           terminal_color_12 "#d3869b"
           terminal_color_13 "#ddc7a1"
           terminal_color_14 "#ebdbb2"
           terminal_color_15 "#fbf1c7"})
       (opt {guifont "VictorMono Nerd Font Mono:h13" termguicolors false})))
