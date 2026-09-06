(import-macros {: cfg : define : with-require} :macros)
(define M :lib.refer)

(fn M.grep-command [query]
  (let [(pattern extensions) (string.match query "^(.-)%s+#([%w_,.%-]+)$")
        cmd [:rg :--vimgrep :--smart-case]]
    (when extensions
      (table.insert cmd :--glob)
      (table.insert cmd
                    (if (string.find extensions "," 1 true)
                        (string.format "*.{%s}" extensions)
                        (string.format "*.%s" extensions))))
    (table.insert cmd "--")
    (table.insert cmd (vim.trim (or pattern query)))
    cmd))

(fn M.refer-window? [buf]
  (let [filetype (vim.api.nvim_get_option_value :filetype {: buf})]
    (or (= filetype :refer_input) (= filetype :refer_results))))

(fn set-window-height [win height]
  (when (and win (vim.api.nvim_win_is_valid win))
    (case (pcall vim.api.nvim_win_get_height win)
      (where (true current-height) (not= current-height height))
      (pcall vim.api.nvim_win_set_height win height))))

(fn M.enforce-refer-height []
  (let [(ok? refer) (pcall require :refer)
        picker (and ok? refer._active_picker)]
    (when picker
      (let [ui picker.ui
            results-height (ui:get_height (length picker.current_matches))]
        (set-window-height ui.results_win results-height)
        (set-window-height ui.input_win 1)))))

(fn M.without-focus-resize [pick]
  (fn [items on-select opts]
    (let [opts (or opts {})
          launch-buf (vim.api.nvim_get_current_buf)
          bufhidden (vim.api.nvim_get_option_value :bufhidden {:buf launch-buf})
          ephemeral? (or (= bufhidden :wipe) (= bufhidden :delete))
          focus-disabled? vim.g.focus_disable
          on-close opts.on_close]
      (when ephemeral?
        (set opts.preview {:enabled false})
        (vim.api.nvim_set_option_value :bufhidden :hide {:buf launch-buf}))
      (set vim.g.focus_disable true)
      (set opts.on_close
           #(do
              (set vim.g.focus_disable focus-disabled?)
              (when ephemeral?
                (vim.schedule #(when (vim.api.nvim_buf_is_valid launch-buf)
                                 (vim.api.nvim_set_option_value :bufhidden
                                                                bufhidden
                                                                {:buf launch-buf}))))
              (when on-close (on-close))))
      (case (pcall pick items on-select opts)
        (where (true picker)) picker
        (where (false err)) (do
                              (set vim.g.focus_disable focus-disabled?)
                              (when (vim.api.nvim_buf_is_valid launch-buf)
                                (vim.api.nvim_set_option_value :bufhidden
                                                               bufhidden
                                                               {:buf launch-buf}))
                              (error err))))))

M
