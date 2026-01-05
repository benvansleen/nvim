(import-macros {: autoload : cfg : require-and-call : setup : with-require}
               :macros)

(autoload {: contains? : keys} :nfnl.core)
(autoload {: join-path} :nfnl.fs)

(cfg (wo {foldlevel 4
          foldmethod :expr
          foldexpr "v:lua.vim.treesitter.foldexpr()"})
     (plugins [:nvim-treesitter
               {:for_cat :general.treesitter
                :event :DeferredUIEnter
                :after #(with-require {: nvim-treesitter}
                          (local install-dir
                                 (join-path [(vim.fn.stdpath :data) :site]))
                          (local parsers
                                 (keys (require :nvim-treesitter.parsers)))
                          (nvim-treesitter.setup {: install-dir})
                          (when (not (vim.uv.fs_stat install-dir))
                            (nvim-treesitter.install parsers))

                          (fn treesitter-attach [{: buf}]
                            (when (not (. vim.b buf :ts-attached))
                              (tset vim.b buf :ts-attached true)
                              (let [ft (. vim.bo buf :filetype)]
                                (when (contains? parsers ft)
                                  (vim.treesitter.start)
                                  (cfg (bo {indentexpr "v:lua.require'nvim-treesitter'.indentexpr()"}))))))

                          (vim.api.nvim_create_autocmd :FileType
                                                       {:group (vim.api.nvim_create_augroup :UserTreesitterAttach
                                                                                            {:clear true})
                                                        :callback treesitter-attach})
                          (vim.api.nvim_exec_autocmds :FileType []))}]
              [:nvim-ts-autotag
               {:for_cat :general.treesitter
                :event :InsertEnter
                :after #(setup :nvim-ts-autotag
                               {:opts {:enable_close true
                                       :enable_rename true
                                       :enable_close_on_slash true}})}]
              [:hlargs.nvim
               {:for_cat :general.treesitter
                :event :DeferredUIEnter
                :after #(setup :hlargs)}]))
