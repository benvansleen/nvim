(import-macros {: autoload
                : cfg
                : is-nix
                : require-and-call
                : setup
                : when-nix
                : with-require} :macros)

(autoload {: pick-tab} :lib.telescope)

(cfg (plugins [:telescope.nvim
               {:for_cat :telescope
                :cmd :Telescope
                :on_require [:telescope]
                :load (fn [name]
                        (vim.cmd.packadd name)
                        (vim.cmd.packadd :telescope-fzf-native.nvim)
                        (when-nix (vim.cmd.packadd :telescope-undo.nvim)
                                  (vim.cmd.packadd :telescope-zf-native.nvim))
                        (vim.cmd.packadd :telescope-zoxide))
                :after #(with-require {: telescope}
                          (telescope.setup {:defaults {:border true
                                                       :layout_config {:horizontal {:prompt_position :top
                                                                                    :width {:padding 5}
                                                                                    :height {:padding 2}
                                                                                    :preview_width 0.5}
                                                                       :vertical {:prompt_position :top
                                                                                  :width {:padding 0.02}
                                                                                  :height {:padding 0}
                                                                                  :preview_height 0.6
                                                                                  :preview_cutoff 12}}
                                                       :layout_strategy :flex
                                                       :path_display [:filename_first]
                                                       :prompt_prefix " "
                                                       :dynamic_preview_title true
                                                       :selection_caret "  "
                                                       :sorting_strategy :ascending}
                                            :extensions {:fzf {:fuzzy true
                                                               :override_generic_sorter true
                                                               :override_file_sorter (not (is-nix))
                                                               :case_mode :smart_case}
                                                         :zf-native {:file {:enable (is-nix)}
                                                                     :generic {:enable false}}
                                                         :undo {:mappings {:i {:<cr> (when-nix (. (require :telescope-undo.actions)
                                                                                                  :restore))}}}}})
                          (telescope.load_extension :fzf)
                          (when-nix (telescope.load_extension :undo)
                                    (telescope.load_extension :zf-native))
                          (telescope.load_extension :zoxide)
                          (require-and-call :theme :set-telescope-highlights))}
               (nmap {["[F]ind [T]ab" :<leader>ft] #(pick-tab)
                      ["[F]ind [D]iagnostic" :<leader>fd] #(require-and-call :telescope.builtin
                                                                             :diagnostics)
                      ["[F]ind [K]eymap" :<leader>fk] #(require-and-call :telescope.builtin
                                                                         :keymaps)
                      ["[F]ind [H]elp" :<leader>fH] #(require-and-call :telescope.builtin
                                                                       :help_tags)
                      ["[F]ind [T]elescope" :<leader>fT] #(require-and-call :telescope.builtin
                                                                            :builtin)
                      ["[F]ind [M]essage" :<leader>fM] "<cmd>Telescope notify<cr>"
                      ["[F]ind [U]ndo" :<leader>fu] "<cmd>Telescope undo<cr>"
                      ["[C]hange [D]irectory" :<leader>cd] "<cmd>Telescope zoxide list<cr>"})]
              [:project.nvim
               {:for_cat :telescope
                :cmd [:Project
                      :ProjectAdd
                      :ProjectConfig
                      :ProjectDelete
                      :ProjectHistory
                      :ProjectRecents
                      :ProjectRoot
                      :ProjectSession]
                :event :DeferredUIEnter
                :after #(do
                          (setup :project
                                 {:telescope {:prefer_file_browser false
                                              :disable_file_picker false}
                                  :different_owners {:allow true}
                                  :lsp {:enabled true}
                                  :exclude_dirs [:/nix/*
                                                 :node_modules/*
                                                 :.venv/*]
                                  :manual_mode false
                                  :scope_chdir :global
                                  :silent_chdir true})
                          (require-and-call :telescope :load_extension
                                            :projects))}
               (nmap {["[P]roject [S]witch" :<leader>ps] "<cmd>Telescope projects theme=dropdown<cr>"})]))
