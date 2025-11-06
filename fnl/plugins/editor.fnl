(import-macros {: config : require-and-call : setup : tb : with-require}
               :macros)

[(tb :comment.nvim {:for_cat :general.extra
                    :event :CursorMoved
                    :after #(setup :Comment)})
 (tb :dial.nvim {:for_cat :general.extra
                 :on_require :dial
                 :keys [(tb :<C-a>
                            #(with-require {dial :dial.map}
                               (dial.manipulate :increment :normal))
                            {:mode [:n] :desc :Increment})
                        (tb :<C-x>
                            #(with-require {dial :dial.map}
                               (dial.manipulate :decrement :normal))
                            {:mode [:n] :desc :Increment})
                        (tb :g<C-a>
                            #(with-require {dial :dial.map}
                               (dial.manipulate :increment :gnormal))
                            {:mode [:n] :desc :Increment})
                        (tb :g<C-x>
                            #(with-require {dial :dial.map}
                               (dial.manipulate :decrement :gnormal))
                            {:mode [:n] :desc :Increment})
                        (tb :<C-a>
                            #(with-require {dial :dial.map}
                               (dial.manipulate :increment :visual))
                            {:mode [:v] :desc :Increment})
                        (tb :<C-x>
                            #(with-require {dial :dial.map}
                               (dial.manipulate :decrement :visual))
                            {:mode [:v] :desc :Increment})
                        (tb :g<C-a>
                            #(with-require {dial :dial.map}
                               (dial.manipulate :increment :gvisual))
                            {:mode [:v] :desc :Increment})
                        (tb :g<C-x>
                            #(with-require {dial :dial.map}
                               (dial.manipulate :decrement :gvisual))
                            {:mode [:v] :desc :Increment})]})
 (tb :direnv-nvim
     {:for_cat :general.extra
      :event :DeferredUIEnter
      :after #(when (= (vim.fn.executable :direnv) 1)
                (require-and-call :direnv :setup
                                  {:autoload_direnv true
                                   :notifications {:silent_autoload true}}))})
 (tb :fidget.nvim {:for_cat :general.extra
                   :event :DeferredUIEnter
                   :after #(setup :fidget)})
 (tb :foldtext-nvim
     {:for_cat :general.extra
      :event :DeferredUIEnter
      :after #(with-require {: foldtext}
                (foldtext.setup)
                (config (opt {fillchars {:eob " " :fold " "}})))})
 (tb :indent-blankline.nvim
     {:for_cat :general.extra
      :event :DeferredUIEnter
      :after #(setup :ibl {:exclude {:filetypes [:dashboard :fennel]}
                           :scope {:enabled true}
                           :indent {:char "│"}})})
 (tb :flash.nvim
     {:for_cat :general.always
      :on_require :flash
      :keys [(tb :s #(require-and-call :flash :jump)
                 {:mode [:n :x :o] :desc :Jump})
             (tb :S #(require-and-call :flash :treesitter)
                 {:mode [:n :x :o] :desc "Jump treesitter"})
             (tb :r #(require-and-call :flash :remote)
                 {:mode [:o] :desc "Flash treesitter node"})
             (tb :R #(require-and-call :flash :treesitter_search)
                 {:mode [:o :x] :desc "Flash treesitter search"})
             (tb :f #(require-and-call :flash.plugins.char :jump)
                 {:mode [:n :x :o] :desc "Flash find next"})
             (tb :t #(require-and-call :flash.plugins.char :jump)
                 {:mode [:n :x :o] :desc "Flash up to"})
             (tb :F #(require-and-call :flash.plugins.char :jump)
                 {:mode [:n :x :o] :desc "Flash find previous"})
             (tb :T #(require-and-call :flash.plugins.char :jump)
                 {:mode [:n :x :o] :desc "Flash find previous up to"})
             (tb :L
                 #(require-and-call :flash :jump
                                    {:pattern (vim.fn.expand :<cword>)})
                 {:mode [:n]})]
      :after #(setup :flash
                     {:labels :asdfghjklqwertyuiop
                      :jump {:autojump false}
                      :label {:uppercase false
                              :style :inline
                              :after false
                              :before true
                              :rainbow {:enabled true}}
                      :modes {:char {:enabled true
                                     :autohide true
                                     :jump_labels true
                                     :multi_line false
                                     :char_actions #{:f :right
                                                     :t :right
                                                     :F :left
                                                     :T :left}}
                              :search {:enabled false}
                              :treesitter {:label {:before true
                                                   :after false
                                                   :style :overlay}
                                           :jump {:pos :range}}
                              :treesitter_search {:label {:before true
                                                          :after false
                                                          :style :overlay}}}})})
 (tb :nvim-autopairs
     {:for_cat :general.always
      :event :InsertEnter
      :after #(setup :nvim-autopairs
                     {:check_ts true
                      :disable_filetype [:TelescopePrompt]
                      :disable_in_macro true
                      :enable_check_bracket_line true})})
 (tb :nvim-highlight-colors
     {:for_cat :general.extra
      :event :DeferredUIEnter
      :after #(setup :nvim-highlight-colors
                     {:render :virtual
                      :virtual_symbol "■"
                      :virtual_symbol_prefix " "
                      :virtual_symbol_suffix " "
                      :virtual_symbol_position :inline})})
 (tb :nvim-surround {:for_cat :general.always
                     :event :CursorMoved
                     :after #(setup :nvim-surround)})
 (tb :undotree {:for_cat :general.extra
                :cmd [:UndotreeToggle
                      :UndotreeHide
                      :UndotreeShow
                      :UndotreeFocus
                      :UndotrPersistUndo]
                :keys [(tb :<leader>u :<cmd>UndotreeToggle<CR>
                           {:mode [:n] :desc "Undo Tree"})]})
 (tb :vim-startuptime
     {:for_cat :general.extra
      :cmd [:StartupTime]
      :before (fn [_]
                (set vim.g.startuptime_event_width 0)
                (set vim.g.startuptime_tries 10)
                (set vim.g.startuptime_exe_path nixCats.packageBinPath))})
 (tb :which-key.nvim
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
                                (tb :<leader>r {:group "[r]ename"})
                                (tb :<leader>r_ {:hidden true})
                                (tb :<leader>t {:group "[t]oggle"})
                                (tb :<leader>t_ {:hidden true})
                                (tb :<leader>w {:group "[w]orkspace"})
                                (tb :<leader>w_ {:hidden true})]))})]
