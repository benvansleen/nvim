(import-macros {: cfg : setup : tb : with-require} :macros)

(cfg (plugins [:nvim-highlight-colors
               {:for_cat :general.extra
                :event :DeferredUIEnter
                :after #(setup :nvim-highlight-colors
                               {:render :virtual
                                :virtual_symbol "■"
                                :virtual_symbol_prefix " "
                                :virtual_symbol_suffix " "
                                :virtual_symbol_position :inline})}]
              [:vim-startuptime
               {:for_cat :general.extra
                :cmd [:StartupTime]
                :before #(cfg (g {startuptime_event_width 0
                                  startuptime_tries 10
                                  startuptime_exe_path nixCats.packageBinPath}))}]
              [:which-key.nvim
               {:for_cat :general.extra
                :event :DeferredUIEnter
                :after #(with-require {: which-key}
                          (which-key.setup {:preset :helix :delay 500})
                          (which-key.add [(tb :<leader><leader>
                                              {:group "buffer commands"})
                                          (tb :<leader><leader>_ {:hidden true})
                                          (tb :<leader>c {:group "[c]ode"})
                                          (tb :<leader>c_ {:hidden true})
                                          (tb :<leader>d {:group "[d]ocument"})
                                          (tb :<leader>d_ {:hidden true})
                                          (tb :<leader>f {:group "[f]ind"})
                                          (tb :<leader>f_ {:hidden true})
                                          (tb :<leader>g {:group "[g]it"})
                                          (tb :<leader>g_ {:hidden true})
                                          (tb :<leader>o {:group "[o]pencode"})
                                          (tb :<leader>o_ {:hidden true})
                                          (tb :<leader>r {:group "[r]ename"})
                                          (tb :<leader>r_ {:hidden true})
                                          (tb :<leader>t {:group "[t]oggle"})
                                          (tb :<leader>t_ {:hidden true})
                                          (tb :<leader>w {:group "[w]orkspace"})
                                          (tb :<leader>w_ {:hidden true})]))}]))
