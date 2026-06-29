(import-macros {: cfg : require-and-call} :macros)

(when vim.g.neovide
  (cfg (g {neovide_scroll_animation_length 0.1
           neovide_cursor_trail_size 0.5
           terminal_color_0 "#1d2021"
           terminal_color_1 "#ea6962"
           terminal_color_2 "#a9b665"
           terminal_color_3 "#e78a4e"
           terminal_color_4 "#7daea3"
           terminal_color_5 "#d3869b"
           terminal_color_6 "#89b482"
           terminal_color_7 "#c7a07a"
           terminal_color_8 "#665c54"
           terminal_color_9 "#ea6962"
           terminal_color_10 "#a9b665"
           terminal_color_11 "#d8a657"
           terminal_color_12 "#7daea3"
           terminal_color_13 "#d3869b"
           terminal_color_14 "#89b482"
           terminal_color_15 "#d4be98"})
       (opt {guifont "VictorMono Nerd Font Mono:h13"
             termguicolors false
             shell :nu})
       (map {[[:n :t] "Navigate up" :<D-k>] #(require-and-call :Navigator :up)
             [[:n :t] "Navigate down" :<D-j>] #(require-and-call :Navigator
                                                                 :down)
             [[:n :t] "Navigate left" :<D-h>] #(require-and-call :Navigator
                                                                 :left)
             [[:n :t] "Navigate right" :<D-l>] #(require-and-call :Navigator
                                                                  :right)
             [[:n :t] "Toggle Terminal" :<D-t>] #(require-and-call :toggleterm
                                                                   :toggle_command)
             [[:t] "pass <A-;> to nushell" "<D-;>"] "<A-;>"})))
