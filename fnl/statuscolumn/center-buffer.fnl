(fn get-buf-ft [win]
  (vim.api.nvim_get_option_value :filetype
                                 {:buf (vim.api.nvim_win_get_buf win)}))

(local disabled-ft [:blink-cmp-documentation
                    :blink-cmp-menu
                    :blink-cmp-signature
                    :dashboard
                    :fidget
                    :flash_prompt
                    :markdown
                    :NeogitPopup
                    :smear-cursor
                    :startuptime
                    :TelescopePrompt
                    :TelescopeResults
                    :wk])

(fn real-window? [win]
  (let [cfg (vim.api.nvim_win_get_config win)
        ft (get-buf-ft win)]
    (and (not cfg.external) (not= ft "")
         (not (vim.tbl_contains disabled-ft ft)))))

(fn count-windows []
  (let [windows (vim.tbl_filter real-window? (vim.api.nvim_tabpage_list_wins 0))]
    (when vim.g._debug_my_center_buffer
      (print (vim.inspect (vim.tbl_map get-buf-ft windows))))
    (let [len (length windows)]
      (if (and (= len 1) (= :toggleterm (get-buf-ft (. windows 1))))
          0
          len))))

(fn center-buffer [buf-ft]
  (let [factor 3
        buf-specific-adjustment (case buf-ft
                                  _ 0)
        screen-width (+ vim.g.my_center_buffer_screen_width
                        buf-specific-adjustment)]
    (if (and vim.g.my_center_buffer (= (count-windows) 1)
             (> vim.o.columns (/ screen-width factor)))
        (string.rep " " (/ (- screen-width 88) factor))
        " ")))

{: center-buffer}
