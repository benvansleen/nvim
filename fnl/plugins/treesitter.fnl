(import-macros {: config : require-and-call : setup : tb} :macros)

[(tb :nvim-treesitter
     {:for_cat :general.treesitter
      :event :DeferredUIEnter
      :load (fn [name]
              (vim.cmd.packadd name)
              (vim.cmd.packadd :nvim-treesitter-textobjects)
              (vim.cmd.packadd :nvim-treesitter-textsubjects)
              (config (wo {foldlevel 4
                           foldmethod :expr
                           foldexpr "v:lua.vim.treesitter.foldexpr()"})))
      :after #(setup :nvim-treesitter.configs
                     {:highlight {:enable true
                                  :additional_vim_regex_highlighting false}
                      :indent {:enable false}
                      :incremental_selection {:enable true
                                              :keymaps {:init_selection :gnn
                                                        :node_incremental :grn
                                                        :scope_incremental :grc
                                                        :node_decremental :grm}}
                      :textsubjects {:enable true
                                     :prev_selection ","
                                     :keymaps {:. :textsubjects-smart
                                               ";" :textsubjects-container-outer
                                               "i;" :textsubjects-container-inner}}
                      :textobjects {:select {:enable true
                                             :disable [:fennel]
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
                                           :swap_previous {:<leader>A "@parameter.inner"}}}})})
 (tb :hlargs.nvim {:for_cat :general.treesitter
                   :event :DeferredUIEnter
                   :after #(setup :hlargs)})]
