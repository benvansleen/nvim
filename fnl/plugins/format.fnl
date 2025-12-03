(import-macros {: cfg : require-and-call : setup} :macros)

(cfg (plugins [:conform.nvim
               {:for_cat :format
                :event :BufWritePre
                :on_require :conform
                :cmd [:ConformInfo :FormatToggle :FormatEnable :FormatDisable]
                :after #(do
                          (setup :conform
                                 {:format_on_save #(when (not vim.g.disable_autoformat)
                                                     {:timeout_ms 1000
                                                      :lsp_fallback :fallback})
                                  :formatters {:treefmt-nix {:command :treefmt
                                                             :args [:--stdin
                                                                    :$FILENAME]
                                                             :cwd (require-and-call :conform.util
                                                                                    :root_file
                                                                                    [:treefmt.nix])}}
                                  :formatters_by_ft {:* (tb :treefmt-nix)
                                                     :fennel (tb :fnlfmt)
                                                     :lua (tb :stylua)
                                                     :python (tb :ruff_format
                                                                 :ruff_organize_imports)}})
                          (vim.api.nvim_create_user_command :FormatDisable
                                                            #(set vim.g.disable_autoformat
                                                                  false)
                                                            {:desc "Disable autoformat-on-save"})
                          (vim.api.nvim_create_user_command :FormatEnable
                                                            #(set vim.g.disable_autoformat
                                                                  true)
                                                            {:desc "Enable autoformat-on-save"})
                          (vim.api.nvim_create_user_command :FormatToggle
                                                            #(set vim.g.disable_autoformat
                                                                  (not vim.g.disable_autoformat))
                                                            {:desc "Toggle autoformat-on-save"}))}
               (nmap {["[F]ormat [F]ile" :<leader>FF] #(require-and-call :conform
                                                                         :format
                                                                         {:lsp_fallback true
                                                                          :async false
                                                                          :timeout_ms 1000})})]))
