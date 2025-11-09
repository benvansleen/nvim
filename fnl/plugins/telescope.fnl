(import-macros {: cfg
                : is-nix
                : require-and-call
                : setup
                : when-nix
                : with-require} :macros)

;; telescope-egrepify-nvim relies on vim.tbl_flatten, which will be
;; deprecated in nvim 0.13. Silence this warning for now.
(set vim.deprecate #nil)

(cfg (plugins [:telescope.nvim
               {:for_cat :general.telescope
                :cmd [:Telescope :LiveGrepGitRoot]
                :on_require [:telescope]
                :load (fn [name]
                        (vim.cmd.packadd name)
                        (vim.cmd.packadd :telescope-cmdline-nvim)
                        (vim.cmd.packadd :telescope-egrepify-nvim)
                        (vim.cmd.packadd :telescope-file-browser.nvim)
                        (vim.cmd.packadd :telescope-fzf-native.nvim)
                        (vim.cmd.packadd :telescope-ui-select.nvim)
                        (vim.cmd.packadd :telescope-undo.nvim)
                        (when-nix (vim.cmd.packadd :telescope-zf-native.nvim))
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
                                            :extensions {:ui-select [(with-require {themes :telescope.themes}
                                                                       (themes.get_dropdown))]
                                                         :cmdline {:picker {:layout_strategy :vertical
                                                                            :layout_config {:prompt_position :top
                                                                                            :anchor :SW
                                                                                            :width {:padding 0}}
                                                                            :prompt_title false
                                                                            :results_title false}
                                                                   :mappings {:run_input :<M-CR>}
                                                                   :output_pane {:enabled true}}
                                                         :egrepify {:AND true
                                                                    :permutations true
                                                                    :lnum true
                                                                    :lnum_hl :EgrepifyLnum
                                                                    :col false
                                                                    :filename_hl "@keyword"
                                                                    :title false
                                                                    :prefixes {:! {:flag :invert-match}
                                                                               :^ {:flag :invert-match}
                                                                               "#" {:flag :glob
                                                                                    :cb #(string.format "*.{%s}"
                                                                                                        $1)}
                                                                               :& {:flag :glob
                                                                                   :cb #(string.format "*{%s}*"
                                                                                                       $1)}}}
                                                         :file_browser (let [fb telescope.extensions.file_browser.actions]
                                                                         {:mappings {:i {:<left> fb.backspace}}
                                                                          :respect_gitignore false
                                                                          :follow_symlinks true})
                                                         :fzf {:fuzzy true
                                                               :override_generic_sorter true
                                                               :override_file_sorter (not (is-nix))
                                                               :case_mode :smart_case}
                                                         :zf-native {:file {:enable (is-nix)}
                                                                     :generic {:enable false}}
                                                         :undo {:mappings {:i {:<cr> (. (require :telescope-undo.actions)
                                                                                        :restore)}}}}})
                          (telescope.load_extension :cmdline)
                          (telescope.load_extension :egrepify)
                          (telescope.load_extension :file_browser)
                          (telescope.load_extension :fzf)
                          (telescope.load_extension :ui-select)
                          (telescope.load_extension :undo)
                          (when-nix (telescope.load_extension :zf-native))
                          (telescope.load_extension :zoxide)
                          (require-and-call :theme :set-telescope-highlights)
                          (require-and-call :theme :set-telescope-highlights)
                          (telescope.load_extension :zoxide)
                          (require-and-call :theme :set-telescope-highlights))}
               (nmap {["Execute extended command" ";"] "<cmd>Telescope cmdline<cr>"
                      ["[F]ind [F]ile" :<leader>ff] "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>"
                      ["Find [P]roject [F]ile" :<leader>pf] #(require-and-call :telescope.builtin
                                                                               :find_files)
                      ["Find [P]roject [W]ord" :<leader>pw] "<cmd>Telescope egrepify<cr>"
                      ["[F]ind in file [H]istory" :<leader>fh] #(require-and-call :telescope.builtin
                                                                                  :oldfiles)
                      ["[F]ind [B]uffer" :<leader>fb] #(require-and-call :telescope.builtin
                                                                         :buffers)
                      ["[F]ind [L]ine" :<leader>fl] #(require-and-call :telescope.builtin
                                                                       :current_buffer_fuzzy_find)
                      ["[F]ind [D]iagnostic" :<leader>fd] #(require-and-call :telescope.builtin
                                                                             :diagnostics)
                      ["[F]ind [R]esume" :<leader>fr] #(require-and-call :telescope.builtin
                                                                         :resume)
                      ["[F]ind [K]eymap" :<leader>fk] #(require-and-call :telescope.builtin
                                                                         :keymaps)
                      ["[F]ind [H]elp" :<leader>fH] #(require-and-call :telescope.builtin
                                                                       :help_tags)
                      ["[F]ind [T]elescope" :<leader>ft] #(require-and-call :telescope.builtin
                                                                            :builtin)
                      ["[F]ind [M]essage" :<leader>fM] "<cmd>Telescope notify<cr>"
                      ["[F]ind [U]ndo" :<leader>fu] "<cmd>Telescope undo<cr>"
                      ["[C]hange [D]irectory" :<leader>cd] "<cmd>Telescope zoxide list<cr>"
                      ["[G]o to [R]eferences" :<leader>gr] #(require-and-call :telescope.builtin
                                                                              :lsp_references)})]
              [:project.nvim
               {:for_cat :general.telescope
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
                                  :allow_different_owners true
                                  :detection_methods [:pattern]
                                  :exclude_dirs [:/nix/*
                                                 :node_modules/*
                                                 :.venv/*]
                                  :manual_mode false
                                  :scope_chdir :global
                                  :silent_chdir true})
                          (require-and-call :telescope :load_extension
                                            :projects))}
               (nmap {["[P]roject [S]witch" :<leader>ps] "<cmd>Telescope projects theme=dropdown"})]))
