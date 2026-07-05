(import-macros {: autoload : cfg : require-and-call : setup : with-require}
               :macros)

(autoload {: contains? : keys} :nfnl.core)

(cfg (wo {foldlevel 4
          foldmethod :expr
          foldexpr "v:lua.vim.treesitter.foldexpr()"})
     (plugins [:nvim-treesitter
               {:for_cat :treesitter
                :after #(with-require {: nvim-treesitter}
                          (nvim-treesitter.setup {})
                          (vim.api.nvim_create_autocmd :FileType
                                                       {:group (vim.api.nvim_create_augroup :UserTreesitter
                                                                                            {:clear true})
                                                        :callback #(when (pcall vim.treesitter.start)
                                                                     (cfg (bo {indentexpr "v:lua.require'nvim-treesitter'.indentexpr()"})))}))}]
              [:nvim-ts-autotag
               {:for_cat :treesitter
                :event :InsertEnter
                :after #(setup :nvim-ts-autotag
                               {:opts {:enable_close true
                                       :enable_rename true
                                       :enable_close_on_slash true}})}]
              [:hlargs.nvim
               {:for_cat :treesitter
                :event :DeferredUIEnter
                :after #(setup :hlargs)}]))
