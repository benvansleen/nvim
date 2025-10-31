(import-macros {: tb : setup : setup- : with-require} :macros)

(let [theme-name :gruvbox-material
      contrast :medium
      colors (with-require {colors :gruvbox-material.colors}
               (colors.get vim.o.background contrast))]
  (setup theme-name {:italics true
                     : contrast
                     :comments {:italics true}
                     :background {:transparent false}
                     :customize (fn [g o]
                                  (when (or (= g :TelescopeBorder)
                                            (= g :TelescopeNormal)
                                            (= g :TelescopePromptNormal)
                                            (= g :TelescopePromptBorder)
                                            (= g :TelescopePromptTitle)
                                            (= g :TelescopePreviewTitle)
                                            (= g :TelescopeResultsTitle))
                                    (set o.link nil)
                                    (set o.bg colors.bg0)
                                    (set o.fg colors.bg0))
                                  (when (or (= g :GreenSign) (= g :RedSign)
                                            (= g :BlueSign))
                                    (set o.bg colors.bg0))
                                  (when (or (= g :Folded) (= g :FoldColumn))
                                    (set o.bg colors.bg0))
                                  o)}))

[(tb :dashboard-nvim
     {:for_cat :general.extra
      :event :VimEnter
      :after (setup- :dashboard
                     {:theme :hyper
                      :change_to_root_vcs true
                      :config {:header ["                                  __                 "
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
                               :week_header {:enable false}}})})
 (tb :smear-cursor.nvim
     {:for_cat :general.extra
      :event :CursorMoved
      :after (setup- :smear_cursor
                     {:smear_between_buffers true
                      :smear_between_neighbor_lines true
                      :scroll_buffer_space true
                      :smear_insert_mode true})})]
