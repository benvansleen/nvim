(import-macros {: cfg : require-and-call : setup : with-require} :macros)

(cfg (plugins [:neogit
               {:for_cat :git
                :cmd :Neogit
                :on_require :neogit
                :after #(setup :neogit
                               {:auto_refresh true
                                :console_timeout 750
                                :filewatcher {:enabled true :interval 1000}
                                :disable_hint true
                                :graph_style :kitty
                                :process_spinner true
                                :mappings {:status {:gr :RefreshBuffer}
                                           :popup {:p :PushPopup :F :PullPopup}}
                                :integrations {:telescope true :codediff true}
                                :signs {:hunk ["" ""]
                                        :item ["" ""]
                                        :section ["" ""]}
                                :commit_editor {:staged_diff_split_kind :auto}
                                :sections {:recent {:folded false}}
                                :remember_settings true
                                :treesitter_diff_highlight true
                                :word_diff_highlight true})}
               (nmap {["Open Neogit" :<leader><leader>g] #(require-and-call :neogit
                                                                            :open
                                                                            {:cwd "%:p:h"
                                                                             :kind :auto})})]
              [:codediff.nvim
               {:for_cat :git
                :on_require :codediff
                :after #(setup :codediff
                               {:diff {:layout :inline}
                                :highlights {:char_brightness 1.15}
                                :keymaps {:view {:next_file :<tab>
                                                 :prev_file :<s-tab>}}})}]
              [:gitsigns.nvim
               {:for_cat :git
                :event :DeferredUIEnter
                :after #(setup :gitsigns
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
                                                 :col 1}})}
               (nmap {["[G]it: [S]tage hunk" :<leader>gs] #(require-and-call :gitsigns
                                                                             :stage_hunk)
                      ["[G]it: [R]eset hunk" :<leader>gR] #(require-and-call :gitsigns
                                                                             :reset_hunk)
                      ["[G]it: [P]review hunk" :<leader>gP] #(require-and-call :gitsigns
                                                                               :preview_hunk_inline)
                      ["[G]it: [N]ext hunk" :<leader>gn] #(require-and-call :gitsigns
                                                                            :next_hunk)
                      ["[G]it: [P]revious hunk" :<leader>gp] #(require-and-call :gitsigns
                                                                                :prev_hunk)})]))
