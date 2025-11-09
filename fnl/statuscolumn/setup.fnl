(import-macros {: cfg} :macros)
(local statuscolumn (require :statuscolumn.statuscolumn))

(fn force-statuscolumn-redraw []
  (when (not= vim.bo.filetype :dashboard)
    (set vim.wo.statuscolumn statuscolumn.activate)))

(fn update-screen-width []
  (set vim.g.my_center_buffer_screen_width vim.o.columns))

(macro toggle-mode- [toggle]
  `(fn []
     (set ,toggle (not ,toggle))
     (update-screen-width)
     (force-statuscolumn-redraw)))

(cfg (g {my_center_buffer true
         _debug_my_center_buffer false
         my_center_buffer_screen_width vim.o.columns})
     (nmap {["[T]oggle [c]enter-buffer" :<leader>tc] (toggle-mode- vim.g.my_center_buffer)
            ["[T]oggle [c]enter-buffer Debug Mode" :<leader>tC] (toggle-mode- vim.g._debug_my_center_buffer)})
     (autocmd {[:BufWinEnter :BufWinLeave] {:callback force-statuscolumn-redraw}
               [:WinNew :WinEnter :WinResized :VimResized] {:callback (fn []
                                                                        (update-screen-width)
                                                                        (force-statuscolumn-redraw))}}))

statuscolumn
