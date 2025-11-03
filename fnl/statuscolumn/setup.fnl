(import-macros {: config} :macros)

(fn get-buf-ft [win]
  (vim.api.nvim_get_option_value :filetype
                                 {:buf (vim.api.nvim_win_get_buf win)}))

(local disabled-ft [:blink-cmp-documentation
                    :blink-cmp-menu
                    :dashboard
                    :dap-repl
                    :dap-view
                    :fidget
                    :markdown
                    :NeogitPopup
                    :smear-cursor
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

(local statuscolumn {})

;; from https://colordesigner.io/gradient-generator
(local colors ["#616161" "#555555" "#494949" "#3e3e3e" "#333333" "#282828"])

(macro disable-for-fts [ft disabled-fts & body]
  `(if (vim.tbl_contains ,disabled-fts ,ft)
       " "
       (do
         ,(unpack body))))

(fn statuscolumn.highlights []
  (each [i fg (ipairs colors)]
    (vim.api.nvim_set_hl 0 (.. :Gradient_ i) {: fg})))

(fn statuscolumn.border [buf-ft]
  (disable-for-fts buf-ft [:dashboard
                           :NeogitStatus
                           :toggleterm
                           :TelescopePrompt]
                   (if (< vim.v.relnum (- (length colors) 1))
                       (.. "%#Gradient_" (+ vim.v.relnum 1) "#│")
                       (.. "%#Gradient_" (length colors) "#│"))))

(fn statuscolumn.number [_]
  (let [linenum (if vim.wo.relativenumber
                    (or (and (= vim.v.relnum 0) vim.v.lnum) vim.v.relnum)
                    (if vim.wo.number
                        vim.v.lnum
                        nil))]
    (if (not= linenum nil)
        (string.format "%4d" linenum) "")))

(fn statuscolumn.center-buffer [buf-ft]
  (let [factor 3
        winwidth (vim.api.nvim_win_get_width 0)
        buf-specific-adjustment (case buf-ft
                                  _ 0)
        screen-width (+ (or vim.g.my_center_buffer_screen_width winwidth)
                        buf-specific-adjustment)]
    (if (and vim.g.my_center_buffer (= (count-windows) 1)
             (> winwidth (/ screen-width factor)))
        (string.rep " " (/ (- screen-width 88) factor))
        " ")))

(fn _G.click_handler []
  (vim.cmd "normal! za"))

(fn statuscolumn.folds [buf-ft]
  (fn calc-folds []
    (let [foldlevel (vim.fn.foldlevel vim.v.lnum)
          foldlevel-before (vim.fn.foldlevel (or (and (>= (- vim.v.lnum 1) 1)
                                                      (- vim.v.lnum 1))
                                                 (- vim.v.lnum 1)))
          foldlevel-after (vim.fn.foldlevel (or (and (<= (+ vim.v.lnum 1)
                                                         (vim.fn.line "$"))
                                                     (+ vim.v.lnum 1))
                                                (vim.fn.line "$")))
          foldclosed (vim.fn.foldclosed vim.v.lnum)]
      (.. "%@v:lua.click_handler@"
          (if (or (not= vim.v.virtnum 0) (= foldlevel 0))
              " "
              (if (and (not= foldclosed -1) (= foldclosed vim.v.lnum))
                  "▶"
                  (if (> foldlevel foldlevel-before) "▽"
                      (if (> foldlevel foldlevel-after) "╰" "│")))))))

  (disable-for-fts buf-ft [:TelescopePrompt :NeogitStatus] (calc-folds)))

(fn statuscolumn.defaults [_]
  "%l%s")

(fn statuscolumn.init []
  (let [buf-ft (-> (vim.api.nvim_get_current_buf)
                   ((fn [buf] (vim.api.nvim_get_option_value :filetype {: buf}))))]
    (statuscolumn.highlights)
    (or (table.concat [(statuscolumn.center-buffer buf-ft)
                       "%s"
                       (statuscolumn.folds buf-ft)
                       "%l"
                       (statuscolumn.border buf-ft)
                       " "]) "")))

(set statuscolumn.activate "%!v:lua.require('statuscolumn.setup').init()")

(fn force-statuscolumn-redraw []
  (set vim.wo.statuscolumn statuscolumn.activate))

(fn update-screen-width []
  (set vim.g.my_center_buffer_screen_width (vim.api.nvim_win_get_width 0)))

(macro toggle-mode- [toggle]
  `(fn []
     (set ,toggle (not ,toggle))
     (update-screen-width)
     (force-statuscolumn-redraw)))

(config (g {my_center_buffer true
            _debug_my_center_buffer false
            my_center_buffer_screen_width (vim.api.nvim_win_get_width 0)})
        (nmap {["[T]oggle [c]enter-buffer" :<leader>tc] (toggle-mode- vim.g.my_center_buffer)
               ["[T]oggle [c]enter-buffer Debug Mode" :<leader>tC] (toggle-mode- vim.g._debug_my_center_buffer)})
        (autocmd {[:BufEnter :BufWinEnter :BufWinLeave :WinEnter :WinLeave] {:callback force-statuscolumn-redraw}
                  [:WinResized :VimResized] {:callback (fn []
                                                         (update-screen-width)
                                                         (force-statuscolumn-redraw))}}))

statuscolumn
