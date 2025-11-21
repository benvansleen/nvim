(import-macros {: autoload : define} :macros)
(autoload {: map : filter : get : contains?} :nfnl.core)
(define M :statuscolumn.center-buffer)

(macro starts-with [s pattern]
  `(= ,pattern (string.sub ,s 1 ,(string.len pattern))))

(fn get-buf-ft [win]
  (vim.api.nvim_get_option_value :filetype
                                 {:buf (vim.api.nvim_win_get_buf win)}))

(local disabled-ft [])

(fn real-window? [win]
  (let [cfg (vim.api.nvim_win_get_config win)
        buf-ft (get-buf-ft win)
        floating? (-> cfg
                      (get :zindex)
                      type
                      (= :number))]
    (and (not cfg.external) (not= buf-ft "") (not floating?)
         (not (contains? disabled-ft buf-ft)))))

(fn count-windows []
  (let [windows (vim.api.nvim_tabpage_list_wins 0)
        real-windows (filter real-window? windows)]
    (when vim.g._debug_my_center_buffer
      (-> windows
          (->> (map get-buf-ft)
               (filter (partial not= :smear-cursor)))
          vim.inspect
          print))
    (length real-windows)))

(fn M.center-buffer [_]
  (let [factor 3
        screen-width vim.g.my_center_buffer_screen_width]
    (if (and vim.g.my_center_buffer (= (count-windows) 1)
             (> vim.o.columns (/ screen-width factor)))
        (string.rep " " (/ (- screen-width 88) factor))
        " ")))

M
