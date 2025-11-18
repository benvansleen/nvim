(import-macros {: cfg : require-and-call : setup} :macros)

(cfg (g {loaded_netrwPlugin 1})
     (plugins [:oil.nvim
               {:for_cat :general.extra
                :cmd :Oil
                :after #(setup :oil
                               {:default_file_explorer true
                                :view_options {:show_hidden true}
                                :columns [:icon :permissions :size]
                                :keymaps {:g? :actions.show_help
                                          :<CR> :actions.select
                                          :<C-v> :actions.select_vsplit
                                          :<C-s> :actions.select_split
                                          :<C-t> :actions.select_tab
                                          :<C-p> :actions.preview
                                          :<C-c> :actions.close
                                          :q :actions.close
                                          :<C-l> :actions.refresh
                                          :- :actions.parent
                                          :_ :actions.open_cwd
                                          "`" :actions.cd
                                          "~" :actions.tcd
                                          :gs :actions.change_sort
                                          :gx :actions.open_external
                                          :g. :actions.toggle_hidden
                                          "g\\" :actions.toggle_trash}
                                :preview_win {:update_on_cursor_moved true
                                              :preview_method :fast_scratch}})}
               (nmap {["Open Parent Directory" "-"] #(require-and-call :oil
                                                                       :open
                                                                       (or vim.g.__oil_last
                                                                           (vim.fn.expand "%:p:h")))
                      ["Open nvim root directory" :<leader>-] "<cmd>Oil .<cr>"})])
     (autocmd {[:BufEnter] {:pattern "oil://*"
                            :group (vim.api.nvim_create_augroup :oil-last
                                                                {:clear true})
                            :callback #(cfg (g {__oil_last (require-and-call :oil
                                                                             :get_current_dir)}))}}))
