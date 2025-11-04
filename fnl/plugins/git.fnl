(import-macros {: tb : setup- : require-and-call : require-and-call-} :macros)

[(tb :neogit {:for_cat :general.git
              :cmd [:Neogit]
              :on_require :neogit
              :keys [(tb :<leader><leader>g
                         (require-and-call- :neogit :open
                                            {:cwd "%:p:h" :kind :replace})
                         {:mode [:n] :desc "Open Neogit"})]
              :after (setup- :neogit
                             {:auto_refresh true
                              :filewatcher {:enabled true :interval 1000}
                              :disable_hint true
                              :graph_style :unicode
                              :process_spinner true
                              :mappings {:status {:gr :RefreshBuffer}
                                         :popup {:p :PushPopup :F :PullPopup}}
                              :integrations {:telescope true :diffview true}
                              :signs {:hunk ["" ""]
                                      :item ["" ""]
                                      :section ["" ""]}})})
 (tb :diffview.nvim {:for_cat :general.git
                     :cmd [:DiffviewOpen :DiffviewFileHistory]
                     :after (setup- :diffview
                                    {:diff_binaries false
                                     :enhanced_diff_hl true
                                     :use_icons true
                                     :show_help_hints true
                                     :watch_index true})})
 (tb :gitsigns.nvim
     {:for_cat :general.git
      :event :DeferredUIEnter
      :keys [(tb " gs" (require-and-call- :gitsigns :stage_hunk)
                 {:mode [:n] :desc "[G]it: [S]tage hunk"})
             (tb " gR" (require-and-call- :gitsigns :reset_hunk)
                 {:mode [:n] :desc "[G]it: [R]eset hunk"})
             (tb " gp" (require-and-call- :gitsigns :preview_hunk_inline)
                 {:mode [:n] :desc "[G]it: [P]review hunk"})]
      :after (setup- :gitsigns
                     {:signs {:add {:text "│"}
                              :change {:text "│"}
                              :delete {:text "_"}
                              :topdelete {:text "‾"}
                              :changedelete {:text "~"}
                              :untracked {:text "┆"}}
                      :signs_staged {:add {:text "│"}
                                     :change {:text "│"}
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
                                       :col 1}})})]
