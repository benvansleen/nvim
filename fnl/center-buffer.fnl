(import-macros {: config} :macros)

(fn get-buf-ft [win]
  (vim.api.nvim_get_option_value :filetype
                                 {:buf (vim.api.nvim_win_get_buf win)}))

(local disabled-ft [:blink-cmp-documentation
                    :blink-cmp-menu
                    :dashboard
                    :fidget
                    :markdown
                    :smear-cursor
                    :toggleterm
                    :TelescopePrompt
                    :TelescopeResults])

(fn real-window? [win]
  (let [cfg (vim.api.nvim_win_get_config win)
        ft (get-buf-ft win)]
    (and (not cfg.external) (not= ft "")
         (not (vim.tbl_contains disabled-ft ft)))))

(fn count-windows []
  (let [windows (vim.tbl_filter real-window? (vim.api.nvim_tabpage_list_wins 0))]
    (when vim.g._debug_my_center_buffer
      (print (vim.inspect (vim.tbl_map get-buf-ft windows))))
    (length windows)))

(let [screen-width (vim.api.nvim_win_get_width 0)
      statuscolumn "  %l%s%C"
      statuscolumn-wide (.. (string.rep " " (/ (- screen-width 100) 3))
                            statuscolumn)]
  (fn center-buffer []
    (let [winwidth (vim.api.nvim_win_get_width 0)]
      (if (and vim.g.my_center_buffer (= (count-windows) 1)
               (> winwidth (/ screen-width 3)))
          (set vim.wo.statuscolumn statuscolumn-wide)
          (set vim.wo.statuscolumn statuscolumn))))

  (config (g {my_center_buffer true _debug_my_center_buffer false})
          (nmap {:<leader>tc (fn []
                               (set vim.g.my_center_buffer
                                    (not vim.g.my_center_buffer)))})
          (autocmd {[:BufEnter
                      :BufWinEnter
                      :BufWinLeave
                      :WinEnter
                      :WinLeave
                      :WinResized
                      :VimResized] {:callback center-buffer}})))
