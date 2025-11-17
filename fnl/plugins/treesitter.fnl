(import-macros {: cfg : require-and-call : setup} :macros)

(cfg (plugins [:nvim-treesitter
               {:for_cat :general.treesitter
                :event :DeferredUIEnter
                :load (fn [name]
                        (vim.cmd.packadd name)
                        (vim.cmd.packadd :nvim-treesitter-textobjects)
                        (cfg (wo {foldlevel 4
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
                                                                  :node_decremental :grm}}})}]
              [:hlargs.nvim
               {:for_cat :general.treesitter
                :event :DeferredUIEnter
                :after #(setup :hlargs)}]))
