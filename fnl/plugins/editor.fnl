(import-macros {: tb : setup- : require-and-call : with-require-} :macros)

[(tb :comment.nvim {:for_cat :general.extra
                    :event :DeferredUIEnter
                    :after (setup- :Comment)})
 (tb :direnv.nvim
     {:for_cat :general.extra
      :event :DeferredUIEnter
      :after (setup- :direnv
                     {:autoload_direnv true
                      :notifications {:silent_autoload true}})})
 (tb :fidget.nvim {:for_cat :general.extra
                   :event :DeferredUIEnter
                   :after (setup- :fidget)})
 (tb :foldtext-nvim {:for_cat :general.extra
                     :event :DeferredUIEnter
                     :after (setup- :foldtext)})
 (tb :indent-blankline.nvim
     {:for_cat :general.extra
      :event :DeferredUIEnter
      :after (setup- :ibl {:exclude {:filetypes [:dashboard :fennel]}})})
 (tb :leap.nvim
     {:for_cat :general.always
      :keys [(tb :s "<Plug>(leap)" {:mode [:n :x :o] :desc :Leap!})]
      :after (with-require- [leap :leap]
               (set leap.opts.safe_labels "")
               (set leap.opts.preview false)
               (vim.api.nvim_set_hl 0 :LeapBackdrop {:link :Comment}))})
 (tb :nvim-autopairs
     {:for_cat :general.always
      :event :InsertEnter
      :after (setup- :nvim-autopairs
                     {:check_ts true
                      :disable_filetype [:TelescopePrompt]
                      :disable_in_macro true
                      :enable_check_bracket_line true})})
 (tb :nvim-surround {:for_cat :general.always
                     :event :DeferredUIEnter
                     :after (setup- :nvim-surround)})
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
      :after (with-require- [which-key :which-key]
               (which-key.setup {})
               (which-key.add [(tb :<leader><leader> {:group "buffer commands"})
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
