(import-macros {: cfg : setup} :macros)

(fn setup-folds [{: buf}]
  (let [win (vim.api.nvim_get_current_win)]
    (when (and (= (vim.api.nvim_win_get_buf win) buf)
               (= (vim.api.nvim_get_option_value :buftype {: buf}) "")
               (not= (vim.api.nvim_get_option_value :filetype {: buf}) :oil)
               (not (. vim.b buf :big_file))
               (pcall vim.treesitter.get_parser buf))
      (vim.api.nvim_set_option_value :foldlevel 7 {:scope :local : win})
      (vim.api.nvim_set_option_value :foldmethod :expr {:scope :local : win})
      (vim.api.nvim_set_option_value :foldexpr
                                     "v:lua.vim.treesitter.foldexpr()"
                                     {:scope :local : win})
      (tset (. vim.w win) :__fdID nil))))

(cfg (wo {foldlevel 7
          foldmethod :expr
          foldexpr "v:lua.vim.treesitter.foldexpr()"})
     (autocmd {[:FileType] {:desc "activate treesitter"
                            :group (vim.api.nvim_create_augroup :UserTreesitter
                                                                {:clear true})
                            :callback (fn [{: buf}]
                                        (when (and (not (. vim.b buf :big_file))
                                                   (pcall vim.treesitter.start
                                                          buf))
                                          (tset (. vim.bo buf) :indentexpr
                                                "v:lua.require'nvim-treesitter'.indentexpr()")
                                          (setup-folds {: buf})))}
               [:BufWinEnter] {:desc "restore treesitter folds for window"
                               :group :UserTreesitter
                               :callback (fn [event]
                                           (vim.schedule #(setup-folds event)))}})
     (plugins [:nvim-treesitter
               {:for_cat :treesitter
                :event [:BufReadPost :BufNewFile :StdinReadPost]
                :after #(setup :nvim-treesitter)}]
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
