(import-macros {: cfg : with-require} :macros)

(fn command-history []
  (with-require {: refer}
    (let [history []
          seen {}]
      (for [index (vim.fn.histnr :cmd) 1 -1]
        (let [command (vim.fn.histget :cmd index)]
          (when (and (not= command "") (not (. seen command)))
            (table.insert history command)
            (tset seen command true))))
      (refer.pick history
                  (fn [command]
                    (let [commands (. (refer.get_commands) :Commands)]
                      (when (= (type commands) :function)
                        (commands {:default_text command}))))
                  {:prompt "Command history > "}))))

(fn refer-window? [buf]
  (let [filetype (vim.api.nvim_get_option_value :filetype {: buf})]
    (or (= filetype :refer_input) (= filetype :refer_results))))

(fn set-window-height [win height]
  (when (and win (vim.api.nvim_win_is_valid win))
    (case (pcall vim.api.nvim_win_get_height win)
      (where (true current-height) (not= current-height height))
      (pcall vim.api.nvim_win_set_height win height))))

(fn enforce-refer-height []
  (let [(ok? refer) (pcall require :refer)
        picker (and ok? refer._active_picker)]
    (when picker
      (let [ui picker.ui
            results-height (ui:get_height (length picker.current_matches))]
        (set-window-height ui.results_win results-height)
        (set-window-height ui.input_win 1)))))

(fn without-focus-resize [pick]
  (fn [items on-select opts]
    (let [opts (or opts {})
          focus-disabled? vim.g.focus_disable
          on-close opts.on_close]
      (set vim.g.focus_disable true)
      (set opts.on_close
           #(do
              (set vim.g.focus_disable focus-disabled?)
              (when on-close (on-close))))
      (case (pcall pick items on-select opts)
        (where (true picker)) picker
        (where (false err)) (do
                              (set vim.g.focus_disable focus-disabled?)
                              (error err))))))

(cfg (plugins [:refer-nvim
               {:for_cat :telescope
                :cmd :Refer
                :before #(vim.cmd.packadd :blink.cmp)
                :after #(with-require {: refer}
                          (refer.setup {:default_sorter :blink
                                        :extras {:find_file true}
                                        :max_height 16
                                        :min_height 16
                                        :providers {:grep {:grep_command [:rg
                                                                          :--vimgrep
                                                                          :--smart-case]}}
                                        :ui {:highlights {:prompt :Title
                                                          :selection :Visual
                                                          :header :WarningMsg}}})
                          (set refer.pick (without-focus-resize refer.pick))
                          (set refer.pick_async
                               (without-focus-resize refer.pick_async))
                          (refer.add_command :CommandHistory command-history)
                          (let [group (vim.api.nvim_create_augroup :ReferWindowSizing
                                                                   {:clear true})]
                            (cfg (autocmd {[:BufEnter :WinEnter] {: group
                                                                  :callback (fn [{: buf}]
                                                                              (when (refer-window? buf)
                                                                                (set vim.w.focus_disable
                                                                                     true)
                                                                                (vim.schedule #(pcall enforce-refer-height))))}
                                           :WinResized {: group
                                                        :callback #(vim.schedule #(pcall enforce-refer-height))}
                                           :FileType {: group
                                                      :pattern :refer_input
                                                      :callback (fn [{: buf}]
                                                                  (vim.keymap.set :n
                                                                                  :j
                                                                                  #(with-require {: refer}
                                                                                     (when refer._active_picker
                                                                                       (refer._active_picker.actions.next_item)))
                                                                                  {:buffer buf
                                                                                   :desc "Next item"})
                                                                  (vim.keymap.set :n
                                                                                  :k
                                                                                  #(with-require {: refer}
                                                                                     (when refer._active_picker
                                                                                       (refer._active_picker.actions.prev_item)))
                                                                                  {:buffer buf
                                                                                   :desc "Previous item"}))}}))))}
               (nmap {["Execute extended command" ";"] #(vim.cmd "Refer Commands")
                      ["Command history" "<leader>;"] #(vim.cmd "Refer CommandHistory")
                      ["[F]ind [F]ile" :<leader>ff] #(vim.cmd "Refer Extras FindFile")
                      ["Find [P]roject [F]ile" :<leader>pf] #(vim.cmd "Refer Files")
                      ["Find [F]ind [W]ord" :<leader>fw] #(vim.cmd "Refer Grep")
                      ["Find [L]ine" :<leader>fl] #(vim.cmd "Refer Lines")
                      ["Find [P]roject [W]ord" :<leader>pw] #(vim.cmd "Refer Grep")
                      ["[F]ind in file [H]istory" :<leader>fh] #(vim.cmd "Refer OldFiles")
                      ["[F]ind [B]uffer" :<leader>fb] #(vim.cmd "Refer Buffers")
                      ["[F]ind [R]esume" :<leader>fr] #(vim.cmd "Refer Resume")
                      ["[F]ind [N]ext" :<leader>fn] #(vim.cmd "Refer Selection")
                      ["[F]ind [S]ymbol" :<leader>fs] #(vim.cmd "Refer Symbols")
                      ["[G]o to [R]eferences" :<leader>gr] #(vim.cmd "Refer References")
                      ["[G]o to [I]mplementations" :<leader>gi] #(vim.cmd "Refer Implementations")})]))
