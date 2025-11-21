(import-macros {: autoload : cfg : require-and-call : setup : with-require}
               :macros)

(autoload {: blank?} :nfnl.string)
(autoload {: contains?} :nfnl.core)
(autoload {: all} :lib.utils)

(cfg (plugins [:dashboard-nvim
               {:for_cat :general.extra
                :event :VimEnter
                :after #(do
                          (setup :dashboard
                                 {:theme :hyper
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
                                                       :action "Telescope egrepify"
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
                                               {:link :Green}))}
               (nmap {["Open Dashboard" :<leader><leader>d] :<cmd>Dashboard<cr>})]
              [:smear-cursor.nvim
               {:for_cat :general.extra
                :event :CursorMoved
                :after #(when (not vim.g.neovide)
                          (setup :smear_cursor
                                 {:smear_between_buffers true
                                  :smear_between_neighbor_lines true
                                  :scroll_buffer_space true
                                  :smear_insert_mode true}))}]
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
                                                  :dap-view-term
                                                  :DiffviewFiles
                                                  :NeogitDiffView]
                                ignore-buftypes [:prompt :popup]
                                group (vim.api.nvim_create_augroup :FocusDisable
                                                                   {:clear true})]
                            (cfg (autocmd {:WinEnter {:desc "Disable focus autoresize for BufType"
                                                      : group
                                                      :callback #(set vim.w.focus_disable
                                                                      (contains? ignore-buftypes
                                                                                 vim.bo.buftype))}
                                           :FileType {:desc "Disable focus autoresize for FileType"
                                                      : group
                                                      :callback #(set vim.b.focus_disable
                                                                      (contains? ignore-filetypes
                                                                                 vim.bo.filetype))}}))))}
               (nmap {["Open [S]plit" :<leader>s] #(require-and-call :focus
                                                                     :split_nicely)
                      ["Close [S]plit" :<leader>S] #(vim.cmd.close)})])
     (autocmd {[:BufDelete] {:group (vim.api.nvim_create_augroup :BufDeletePostSetup
                                                                 {:clear true})
                             :nested true
                             :callback #(vim.schedule #(vim.api.nvim_exec_autocmds :User
                                                                                   {:pattern :BufDeletePost}))}
               [:User] {:pattern :BufDeletePost
                        :group (vim.api.nvim_create_augroup :BufDeletePost
                                                            {:clear true})
                        :callback (fn [{: buf}]
                                    (let [deleted-name (vim.api.nvim_buf_get_name buf)
                                          deleted-ft (vim.api.nvim_get_option_value :filetype
                                                                                    {: buf})
                                          deleted-bt (vim.api.nvim_get_option_value :buftype
                                                                                    {: buf})]
                                      (when (all blank?
                                                 [deleted-name
                                                  deleted-ft
                                                  deleted-bt])
                                        (vim.cmd :Dashboard))))}}))
