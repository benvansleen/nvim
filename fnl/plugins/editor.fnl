(import-macros {: cfg : require-and-call : setup : with-require} :macros)

(cfg (plugins [:comment.nvim
               {:for_cat :general.extra
                :event :CursorMoved
                :after #(setup :Comment)}]
              [:dial.nvim
               {:for_cat :general.extra :on_require :dial}
               (nmap {[:Increment :<C-a>] #(with-require {dial :dial.map}
                                             (dial.manipuluate :increment
                                                               :normal))
                      [:Decrement :<C-x>] #(with-require {dial :dial.map}
                                             (dial.manipulate :decrement
                                                              :normal))
                      [:Increment :g<C-a>] #(with-require {dial :dial.map}
                                              (dial.manipulate :increment
                                                               :gnormal))
                      [:Decrement :g<C-x>] #(with-require {dial :dial.map}
                                              (dial.manipulate :decrement
                                                               :gnormal))})
               (vmap {[:Increment :<C-a>] #(with-require {dial :dial.map}
                                             (dial.manipuluate :increment
                                                               :visual))
                      [:Decrement :<C-x>] #(with-require {dial :dial.map}
                                             (dial.manipulate :decrement
                                                              :visual))
                      [:Increment :g<C-a>] #(with-require {dial :dial.map}
                                              (dial.manipulate :increment
                                                               :gvisual))
                      [:Decrement :g<C-x>] #(with-require {dial :dial.map}
                                              (dial.manipulate :decrement
                                                               :gvisual))})]
              [:direnv-nvim
               {:for_cat :general.extra
                :event :DeferredUIEnter
                :after #(when (= (vim.fn.executable :direnv) 1)
                          (setup :direnv-nvim
                                 {:async true
                                  :on_direnv_finished #(when (> (vim.fn.exists ":LspStart")
                                                                0)
                                                         (vim.cmd :LspStart))
                                  :type :buffer}))}]
              [:fidget.nvim
               {:for_cat :general.extra
                :event :DeferredUIEnter
                :after #(setup :fidget)}]
              [:foldtext-nvim
               {:for_cat :general.extra
                :event :DeferredUIEnter
                :after #(do
                          (setup :foldtext)
                          (cfg (opt {fillchars {:eob " " :fold " "}})))}]
              [:indent-blankline.nvim
               {:for_cat :general.extra
                :event :DeferredUIEnter
                :after #(setup :ibl
                               {:exclude {:filetypes [:dashboard :fennel]}
                                :scope {:enabled true
                                        :show_exact_scope false
                                        :show_start true
                                        :show_end true}
                                :indent {:char "│"}})}]
              [:flash.nvim
               {:for_cat :general.always
                :on_require :flash
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
                                                                    :style :overlay}}}})}
               (map {[[:n :x :o] :Jump :s] #(require-and-call :flash :jump)
                     [[:n :x :o] "Jump treesitter" :S] #(require-and-call :flash
                                                                          :treesitter)
                     [[:o] "Flash remote" :r] #(require-and-call :flash :remote)
                     [[:x :o] "Flash treesitter search" :R] #(require-and-call :flash
                                                                               :treesitter_search)
                     [[:n :x :o] "Flash find next" :f] #(require-and-call :flash.plugins.char
                                                                          :jump)
                     [[:n :x :o] "Flash find previous" :F] #(require-and-call :flash.plugins.char
                                                                              :jump)
                     [[:n :x :o] "Flash up to" :t] #(require-and-call :flash.plugins.char
                                                                      :jump)
                     [[:n :x :o] "Flash up to previous" :T] #(require-and-call :flash.plugins.char
                                                                               :jump)})]
              [:nvim-autopairs
               {:for_cat :general.always
                :event :InsertEnter
                :after #(setup :nvim-autopairs
                               {:check_ts true
                                :disable_filetype [:TelescopePrompt]
                                :disable_in_macro true
                                :enable_check_bracket_line true})}]
              [:nvim-surround
               {:for_cat :general.always
                :event :CursorMoved
                :after #(setup :nvim-surround)}]
              [:undotree
               {:for_cat :general.extra
                :cmd [:UndotreeToggle
                      :UndotreeHide
                      :UndotreeShow
                      :UndotreeFocus
                      :UndotrPersistUndo]}
               (nmap {["Undo Tree" :<leader>u] :<cmd>UndotreeToggle<cr>})]))
