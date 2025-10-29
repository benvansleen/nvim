(import-macros {: tb : setup- : require-and-call} :macros)

[(tb :toggleterm.nvim
     {:for_cat :general.extra
      :event :DeferredUIEnter
      :after (setup- :toggleterm
                     {:open_mapping :<M-t>
                      :direction :vertical
                      :persist_size true
                      :size (fn [term]
                              (case term.direction
                                :horizontal 15
                                :vertical (* vim.o.columns 0.4)))})})]
