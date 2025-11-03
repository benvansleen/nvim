(import-macros {: tb : require-and-call- : setup-} :macros)

[(tb :toggleterm.nvim
     {:for_cat :general.extra
      :on_require :toggleterm
      :keys [(tb :<M-t> (require-and-call- :toggleterm :toggle_command)
                 {:desc "Toggle Terminal"})]
      :after (setup- :toggleterm
                     {:open_mapping :<M-t>
                      :direction :vertical
                      :persist_size true
                      :size (fn [term]
                              (case term.direction
                                :horizontal 15
                                :vertical (* vim.o.columns 0.4)))
                      :shade_terminals false})})]
