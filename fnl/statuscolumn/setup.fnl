(import-macros {: cfg} :macros)
(local statuscolumn (require :statuscolumn.statuscolumn))

;; fnlfmt: skip
(fn force-window-relayout [win]
  "briefly toggle a window option to force a per-window layout recompute"
  (let [opts [:number :relativenumber :foldcolumn :signcolumn]]
    (var success nil)
    (each [_ opt (ipairs opts)]
      (case (pcall vim.api.nvim_win_get_option win opt)
        (where (true cur) (not success))
        (if (= (type cur) :boolean)
            (do
              (set success (pcall vim.api.nvim_win_set_option win opt
                                  (not cur)))
              (when success
                (pcall vim.api.nvim_win_set_option win opt cur)))
            (let [alt (if (or (= cur "") (= cur :0)) :1 "")]
              (set success (pcall vim.api.nvim_win_set_option win opt alt))
              (when success
                (pcall vim.api.nvim_win_set_option win opt cur)))))))
  false)

(fn refresh-nonfloating-windows []
  "briefly toggle a window option on every non-floating window"
  (each [_ win (ipairs (vim.api.nvim_list_wins))]
    (case (pcall vim.api.nvim_win_get_config win)
      (where (true config) (or (= config.relative "") (= config.relative nil)))
      (pcall force-window-relayout win))))

(fn update-screen-width []
  (when (not= vim.bo.filetype :dashboard)
    (cfg (g {my_center_buffer_screen_width vim.o.columns})
         (wo {statuscolumn (statuscolumn.activate)}))))

(macro toggle-mode- [toggle]
  `(fn []
     (set ,toggle (not ,toggle))
     (update-screen-width)))

(local group (vim.api.nvim_create_augroup :center-buffer {:clear true}))
(cfg (g {my_center_buffer true
         _debug_my_center_buffer false
         my_center_buffer_screen_width vim.o.columns})
     (nmap {["[T]oggle [c]enter-buffer" :<leader>tc] (toggle-mode- vim.g.my_center_buffer)
            ["[T]oggle [c]enter-buffer Debug Mode" :<leader>tC] (toggle-mode- vim.g._debug_my_center_buffer)})
     (autocmd {[:WinEnter :WinResized :VimResized] {: group
                                                    :callback update-screen-width}
               [:WinNew :WinClosed] {: group
                                     :callback #(let [win (or (tonumber $1.match)
                                                              0)]
                                                  (case (pcall vim.api.nvim_win_get_config
                                                               win)
                                                    (where (true config)
                                                           (and config
                                                                (= config.relative
                                                                   "")))
                                                    (refresh-nonfloating-windows)))}}))

statuscolumn
