(import-macros {: tb : require-and-call} :macros)

(tb :nvim-treesitter
    {:for_cat :general.treesitter
     :event :DeferredUIEnter
     :load (fn [name]
             (vim.cmd.packadd name)
             (vim.cmd.packadd :nvim-treesitter-textobjects))
     :after (fn [_]
              (let [ts (require :nvim-treesitter.configs)]
                (ts.setup {:highlight {:enable true}
                           :indent {:enable false}
                           :incremental_selection {:enable true :keymaps {}}
                           :textobjects {:select {:enable false
                                                  :lookahead true
                                                  :keymaps {:aa "@parameter.outer"
                                                            :ia "@parameter.inner"
                                                            :af "@function.outer"
                                                            :if "@function.inner"
                                                            :ac "@class.outer"
                                                            :ic "@class.inner"}}
                                         :move {:enable true
                                                :set_jumps true
                                                :goto_next_start {"]m" "@function.outer"
                                                                  "]]" "@class.outer"}
                                                :goto_next_end {"]M" "@function.outer"
                                                                "][" "@class.outer"}
                                                :goto_previous_start {"[m" "@function.outer"
                                                                      "[[" "@class.outer"}
                                                :goto_previous_end {"[M" "@function.outer"
                                                                    "[]" "@class.outer"}}
                                         :swap {:enable true
                                                :swap_next {:<leader>a "@parameter.inner"}
                                                :swap_previous {:<leader>A "@parameter.inner"}}}})))})
