(import-macros {: cfg : require-and-call : setup : with-require} :macros)

(cfg (plugins [:dashboard-nvim
               {:for_cat :general.extra
                :event :VimEnter
                :after #(with-require {: dashboard}
                          (dashboard.setup {:theme :hyper
                                            :change_to_root_vcs true
                                            :config {:header ["                                 __                 "
                                                              "  ___     ___    ___   __  __ /\\_\\    ___ ___   "
                                                              " / _ `\\  / __`\\ / __`\\/\\ \\/\\ \\\\/\\ \\  / __` __`\\ "
                                                              "/\\ \\/\\ \\/\\  __//\\ \\_\\ \\ \\ \\_/ |\\ \\ \\/\\ \\/\\ \\/\\ \\"
                                                              " \\ \\_\\ \\_\\ \\____\\ \\____/\\ \\___/  \\ \\_\\ \\_\\ \\_\\ \\_\\"
                                                              "  \\/_/\\/_/\\/____/\\/___/  \\/__/    \\/_/\\/_/\\/_/\\/_/"
                                                              ""]
                                                     :footer {}
                                                     :packages {:enable false}
                                                     :shortcut [{:desc :Files
                                                                 :group :Label
                                                                 :action "Telescope find_files"
                                                                 :key :f}
                                                                {:desc "Recent Files"
                                                                 :group :Error
                                                                 :action "Telescope oldfiles"
                                                                 :key :r}
                                                                {:desc "Find Word"
                                                                 :group :Warning
                                                                 :action "Telescope live_grep"
                                                                 :key :w}
                                                                {:desc "Find Project"
                                                                 :group "@module"
                                                                 :action "Telescope projects theme=dropdown"
                                                                 :key :p}
                                                                {:desc :Git
                                                                 :group "@property"
                                                                 :action :Neogit
                                                                 :key :g}
                                                                {:desc "Change Directory"
                                                                 :group "@constant"
                                                                 :action "Telescope zoxide list"
                                                                 :key :c}
                                                                {:desc :Dotfiles
                                                                 :group :Number
                                                                 :action "Telescope find_files cwd=~/.config"
                                                                 :key :d}]
                                                     :week_header {:enable false}}})
                          (vim.api.nvim_set_hl 0 :DashboardHeader {:link :Blue})
                          (vim.api.nvim_set_hl 0 :DashboardFiles
                                               {:link "@comment"})
                          (vim.api.nvim_set_hl 0 :DashboardProjectTitle
                                               {:link :Purple})
                          (vim.api.nvim_set_hl 0 :DashboardMruTitle
                                               {:link :Red})
                          (vim.api.nvim_set_hl 0 :DashboardShortCut
                                               {:link :Green}))}]
              [:smear-cursor.nvim
               {:for_cat :general.extra
                :event :CursorMoved
                :after #(setup :smear_cursor
                               {:smear_between_buffers true
                                :smear_between_neighbor_lines true
                                :scroll_buffer_space true
                                :smear_insert_mode true})}]
              [:helpview.nvim
               {:for_cat :general.extra
                :ft :help
                :after #(setup :helpview
                               {:preview {:enable true
                                          :splitview_winopts {:split :right}}})}]
              [:focus.nvim
               {:for_cat :general.extra
                :event :DeferredUIEnter
                :after #(with-require {: focus}
                          (focus.setup {:enable true
                                        :commands true
                                        :autoresize {:enable true}
                                        :split {:tmux false :bufnew false}
                                        :ui {:cursorline false
                                             :signcolumn false
                                             :winhighlight false}})
                          (let [ignore-filetypes [:TelescopePrompt
                                                  :TelescopeResults
                                                  :dap-repl
                                                  :dap-view
                                                  :dap-view-term]
                                ignore-buftypes [:prompt :popup]
                                augroup (vim.api.nvim_create_augroup :FocusDisable
                                                                     {:clear true})]
                            (cfg (autocmd {:WinEnter {:desc "Disable focus autoresize for BufType"
                                                      :callback (fn [_]
                                                                  (set vim.w.focus_disable
                                                                       (vim.tbl_contains ignore-buftypes
                                                                                         vim.bo.buftype)))
                                                      :group augroup}
                                           :FileType {:desc "Disable focus autoresize for FileType"
                                                      :callback (fn [_]
                                                                  (set vim.b.focus_disable
                                                                       (vim.tbl_contains ignore-filetypes
                                                                                         vim.bo.filetype)))
                                                      :group augroup}}))))}
               (nmap {["Open [S]plit" :<leader>s] #(require-and-call :focus
                                                                     :split_nicely)})]))
