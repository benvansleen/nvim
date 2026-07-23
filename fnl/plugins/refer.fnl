(import-macros {: autoload : cfg : with-require} :macros)
(autoload {: enforce-refer-height
           : grep-command
           : refer-window?
           : without-focus-resize} :lib.refer)

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
                  #(let [commands (. (refer.get_commands) :Commands)]
                     (when (= (type commands) :function)
                       (commands {:default_text $1})))
                  {:prompt "Command history > "}))))

(set vim.ui.select (fn [...]
                     (with-require {: refer}
                       (refer.setup_ui_select))
                     (vim.ui.select ...)))

(cfg (plugins [:refer-nvim
               {:for_cat :telescope
                :cmd :Refer
                :on_require :refer
                :before #(vim.cmd.packadd :blink.cmp)
                :after #(with-require {: refer}
                          (refer.setup {:default_sorter :blink
                                        :extras {:find_file true}
                                        :keymaps {:<C-j> {:action :next_item
                                                          :description "Next item"}
                                                  :<C-k> {:action :prev_item
                                                          :description "Previous item"}}
                                        :max_height 16
                                        :min_height 16
                                        :providers {:grep {:grep_command #(grep-command $1)}}
                                        :ui {:highlights {:prompt :Title
                                                          :selection :Visual
                                                          :header :WarningMsg}}})
                          (set refer.pick (without-focus-resize refer.pick))
                          (set refer.pick_async
                               (without-focus-resize refer.pick_async))
                          (let [commands (. (refer.get_commands) :Commands)]
                            (tset (refer.get_commands) :Commands
                                  (fn [opts]
                                    (commands (vim.tbl_deep_extend :force
                                                                   (or opts {})
                                                                   {:prompt "> "})))))
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
                                                                                   :desc "Previous item"})
                                                                  (vim.keymap.set :n
                                                                                  :<cr>
                                                                                  #(with-require {: refer}
                                                                                     (when refer._active_picker
                                                                                       (refer._active_picker.actions.select_entry)))
                                                                                  {:buffer buf
                                                                                   :desc "Select entry"}))}}))))}
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
                      ["[F]ind [S]ymbol" :<leader>fs] #(vim.cmd "Refer Symbols")})]))
