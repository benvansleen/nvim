(import-macros {: cfg : require-and-call : setup} :macros)

(cfg (plugins [:toggleterm.nvim
               {:for_cat :general.extra
                :on_require :toggleterm
                :after #(setup :toggleterm
                               {:open_mapping :<M-t>
                                :direction :vertical
                                :persist_size false
                                :size (fn [{: direction}]
                                        (case direction
                                          :horizontal 15
                                          :vertical (* vim.o.columns 0.45)))
                                :shade_terminals false})}
               (nmap {["Toggle Terminal" :<M-t>] #(require-and-call :toggleterm
                                                                    :toggle_command)})]))
