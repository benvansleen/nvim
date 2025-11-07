(import-macros {: cfg : require-and-call : setup} :macros)

(cfg (plugins [[:toggleterm.nvim
                {:for_cat :general.extra
                 :on_require :toggleterm
                 :after #(setup :toggleterm {:open_mapping :<M-t>})}
                (nmap {["Toggle Terminal" :<M-t>] #(require-and-call :toggleterm
                                                                     :toggle_command)})]]))
