(import-macros {: config : require-and-call : tb : with-require} :macros)

;; telescope-egrepify-nvim relies on vim.tbl_flatten, which will be
;; deprecated in nvim 0.13. Silence this warning for now.
(set vim.deprecate #nil)

(tb :telescope.nvim
    {:for_cat :general.telescope
     :cmd [:Telescope :LiveGrepGitRoot]
     :on_require [:telescope]
     :keys [(tb ";" "<cmd>Telescope cmdline<CR>"
                {:mode [:n] :desc "Execute extended command"})
            (tb :<leader>ff
                "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>"
                {:mode [:n] :desc "[F]ind [F]ile"})
            (tb :<leader>pf #(require-and-call :telescope.builtin :find_files)
                {:mode [:n] :desc "Find [P]roject [F]ile"})
            (tb :<leader>pw "<cmd>Telescope egrepify<cr>"
                {:mode [:n] :desc "Find [P]roject [W]ord"})
            (tb :<leader>fh #(require-and-call :telescope.builtin :oldfiles)
                {:mode [:n] :desc "[F]ind in file [H]istory"})
            (tb :<leader>fb #(require-and-call :telescope.builtin :buffers)
                {:mode [:n] :desc "[F]ind [B]uffer"})
            (tb :<leader>fl
                #(require-and-call :telescope.builtin
                                   :current_buffer_fuzzy_find)
                {:mode [:n] :desc "[F]ind [L]ine"})
            (tb :<leader>fd #(require-and-call :telescope.builtin :diagnostics)
                {:mode [:n] :desc "[F]ind [D]iagnostic"})
            (tb :<leader>fr #(require-and-call :telescope.builtin :resume)
                {:mode [:n] :desc "[F]ind [R]resume"})
            (tb :<leader>fk #(require-and-call :telescope.builtin :keymaps)
                {:mode [:n] :desc "[F]ind [K]eymap"})
            (tb :<leader>fH #(require-and-call :telescope.builtin :help_tags)
                {:mode [:n] :desc "[F]ind [H]elp"})
            (tb :<leader>fm "<cmd>Telescope notify<CR>"
                {:mode [:n] :desc "[F]ind [M]essage"})
            (tb :<leader>ft #(require-and-call :telescope.builtin :builtin)
                {:mode [:n] :desc "[F]ind [T]elescope"})
            (tb :<leader>ps "<cmd>Telescope zoxide list<CR>"
                {:mode [:n] :desc "[P]roject [S]earch"})
            (tb :<leader>gr
                #(require-and-call :telescope.builtin :lsp_references)
                {:mode [:n] :desc "[G]o to [R]eferences"})]
     :load (fn [name]
             (vim.cmd.packadd name)
             (vim.cmd.packadd :telescope-cmdline-nvim)
             (vim.cmd.packadd :telescope-egrepify-nvim)
             (vim.cmd.packadd :telescope-file-browser.nvim)
             (vim.cmd.packadd :telescope-fzf-native.nvim)
             (vim.cmd.packadd :telescope-ui-select.nvim)
             (vim.cmd.packadd :telescope-zf-native.nvim)
             (vim.cmd.packadd :telescope-zoxide))
     :after #(with-require {: telescope}
               (config (autocmd {[:User] {:pattern :TelescopeFindPre
                                          :callback #(set vim.g._start_buf
                                                          (vim.api.nvim_get_current_buf))}}))
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
                                                            (themes.get_cursor))]
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
                                                                    :> {:flag :glob
                                                                        :cb #(string.format "**/{%s}*/**"
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
                                                    :override_file_sorter false
                                                    :case_mode :smart_case}
                                              :zf-native {:file {:enable true
                                                                 :initial_sort #(let [pattern (-> vim.g._start_buf
                                                                                                  vim.api.nvim_buf_get_name
                                                                                                  (vim.fn.fnamemodify ":e")
                                                                                                  (#(.. "%."
                                                                                                        $1
                                                                                                        "$")))]
                                                                                  (if ($1:match pattern)
                                                                                      0
                                                                                      1))}
                                                          :generic {:enable false}}}})
               (telescope.load_extension :cmdline)
               (telescope.load_extension :egrepify)
               (telescope.load_extension :file_browser)
               (telescope.load_extension :fzf)
               (telescope.load_extension :ui-select)
               (telescope.load_extension :zf-native)
               (telescope.load_extension :zoxide)
               (require-and-call :theme :set-telescope-highlights))})
