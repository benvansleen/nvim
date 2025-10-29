(import-macros {: tb : require-and-call : with-require : with-require-} :macros)

(tb :telescope.nvim
    {:for_cat :general.telescope
     :cmd [:Telescope :LiveGrepGitRoot]
     :on_require [:telescope]
     :keys [(tb ";" "<cmd>Telescope cmdline<CR>"
                {:mode [:n] :desc "Execute extended command"})
            (tb :<leader>ff
                "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>"
                {:mode [:n] :desc "[F]ind [F]ile"})
            (tb :<leader>pf (require-and-call :telescope.builtin :find_files)
                {:mode [:n] :desc "Find [P]roject [F]ile"})
            (tb :<leader>pw (require-and-call :telescope.builtin :live_grep)
                {:mode [:n] :desc "Find [P]roject [W]ord"})
            (tb :<leader>fh (require-and-call :telescope.builtin :oldfiles)
                {:mode [:n] :desc "[F]ind in file [H]istory"})
            (tb :<leader>fb (require-and-call :telescope.builtin :buffers)
                {:mode [:n] :desc "[F]ind [B]uffer"})
            (tb :<leader>fl
                (require-and-call :telescope.builtin :current_buffer_fuzzy_find)
                {:mode [:n] :desc "[F]ind [L]ine"})
            (tb :<leader>fd (require-and-call :telescope.builtin :diagnostics)
                {:mode [:n] :desc "[F]ind [D]iagnostic"})
            (tb :<leader>fr (require-and-call :telescope.builtin :resume)
                {:mode [:n] :desc "[F]ind [R]resume"})
            (tb :<leader>fk (require-and-call :telescope.builtin :keymaps)
                {:mode [:n] :desc "[F]ind [K]eymap"})
            (tb :<leader>fH (require-and-call :telescope.builtin :help_tags)
                {:mode [:n] :desc "[F]ind [H]elp"})
            (tb :<leader>fm "<cmd>Telescope notify<CR>"
                {:mode [:n] :desc "[F]ind [M]essage"})
            (tb :<leader>ft (require-and-call :telescope.builtin :builtin)
                {:mode [:n] :desc "[F]ind [T]elescope"})
            (tb :<leader>fc "<cmd>Telescope zoxide list<CR>"
                {:mode [:n] :desc "[F]ind [C]hange [D]irectory"})
            (tb :<leader>gr
                (require-and-call :telescope.builtin :lsp_references)
                {:mode [:n] :desc "[G]o to [R]eferences"})]
     :load (fn [name]
             (vim.cmd.packadd name)
             (vim.cmd.packadd :telescope-fzf-native.nvim)
             (vim.cmd.packadd :telescope-ui-select.nvim)
             (vim.cmd.packadd :telescope-file-browser.nvim)
             (vim.cmd.packadd :telescope-cmdline)
             (vim.cmd.packadd :telescope-zoxide))
     :after (with-require- [telescope :telescope]
              (telescope.setup {:defaults {:border true
                                           :layout_config {:horizontal {:prompt_position :top
                                                                        :width {:padding 0}
                                                                        :height {:padding 0}
                                                                        :preview_width 0.5}
                                                           :vertical {:prompt_position :top
                                                                      :width {:padding 0.02}
                                                                      :height {:padding 0}
                                                                      :preview_height 0.6}}
                                           :layout_strategy :vertical
                                           :path_display [:filename_first]
                                           :prompt_prefix " "
                                           :prompt_title false
                                           :results_title false
                                           :selection_caret " "
                                           :sorting_strategy :ascending}
                                :extensions {:ui-select [(with-require [themes
                                                                        :telescope.themes]
                                                           (themes.get_cursor))]
                                             :cmdline {:picker ((. (require :telescope.themes)
                                                                   :get_ivy) {:layout_config {:height 0.3}})}
                                             :file_browser (let [fb telescope.extensions.file_browser.actions]
                                                             {:mappings {:i {:<left> fb.backspace}}})
                                             :fzf {:fuzzy true
                                                   :override_generic_sorter true
                                                   :override_file_sorter true
                                                   :case_mode :smart_case}}})
              (telescope.load_extension :ui-select)
              (telescope.load_extension :fzf)
              (telescope.load_extension :file_browser)
              (telescope.load_extension :cmdline)
              (telescope.load_extension :zoxide))})
