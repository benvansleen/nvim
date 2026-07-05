(import-macros {: cfg : setup} :macros)

(cfg (wo {foldlevel 4
          foldmethod :expr
          foldexpr "v:lua.vim.treesitter.foldexpr()"})
     (autocmd {[:FileType] {:desc "activate treesitter"
                            :group (vim.api.nvim_create_augroup :UserTreesitter
                                                                {:clear true})
                            :callback (fn [{: buf}]
                                        (when (pcall vim.treesitter.start buf)
                                          (tset (. vim.bo buf) :indentexpr
                                                "v:lua.require'nvim-treesitter'.indentexpr()")))}})
     (plugins [:nvim-treesitter
               {:for_cat :treesitter :after #(setup :nvim-treesitter)}]
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
