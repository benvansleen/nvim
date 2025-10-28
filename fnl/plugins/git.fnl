(import-macros {: tb : require-and-call} :macros)

[(tb :neogit
     {:for_cat :general.always
      :cmd [:Neogit]
      :keys [(tb "  g"
                 (require-and-call :neogit :open {:cwd "%:p:h" :kind :auto})
                 {:mode [:n] :desc "Open Neogit"})]
      :after (fn []
               (let [neogit (require :neogit)]
                 (neogit.setup {:disable_hint true
                                :mappings {:status {:gr :RefreshBuffer}
                                           :popup {:p :PushPopup :F :PullPopup}}})))})
 (tb :gitsigns.nvim
     {:for_cat :general.always
      :event :DeferredUIEnter
      :keys [(tb " gs" (require-and-call :gitsigns :stage_hunk)
                 {:mode [:n] :desc "[G]it: [S]tage hunk"})
             (tb " gr" (require-and-call :gitsigns :reset_hunk)
                 {:mode [:n] :desc "[G]it: [R]eset hunk"})
             (tb " gp" (require-and-call :gitsigns :preview_hunk_inline)
                 {:mode [:n] :desc "[G]it: [P]review hunk"})]
      :after (fn []
               (let [gitsigns (require :gitsigns)]
                 (gitsigns.setup {:signs {:add {:text "┃"}
                                          :change {:text "┃"}
                                          :delete {:text "_"}
                                          :topdelete {:text "‾"}
                                          :changedelete {:text "~"}
                                          :untracked {:text "┆"}}
                                  :signs_staged {:add {:text "┃"}
                                                 :change {:text "┃"}
                                                 :delete {:text "_"}
                                                 :topdelete {:text "‾"}
                                                 :changedelete {:text "~"}
                                                 :untracked {:text "┆"}}
                                  :signs_staged_enable false
                                  :signcolumn true
                                  :numhl false
                                  :linehl false
                                  :word_diff false
                                  :watch_gitdir {:follow_files true}
                                  :auto_attach true
                                  :attach_to_untracked false
                                  :current_line_blame true
                                  ;; :Gitsigns toggle_current_line_blame
                                  :current_line_blame_opts {:virt_text true
                                                            :virt_text_pos :eol
                                                            :delay 1000
                                                            :ignore_whitespace false
                                                            :virt_text_priority 100
                                                            :use_focus true}
                                  :current_line_blame_formatter "<author>, <author_time:%R> - <summary>"
                                  :sign_priority 6
                                  :update_debounce 100
                                  :status_formatter nil
                                  :max_file_length 40000
                                  :preview_config {:style :minimal
                                                   :relative :cursor
                                                   :row 0
                                                   :col 1}})))})]
