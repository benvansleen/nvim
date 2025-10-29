(import-macros {: tb : setup : setup- : with-require} :macros)

(let [theme-name :gruvbox-material
      contrast :medium
      colors (with-require [colors :gruvbox-material.colors]
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
                                  o)}))

(tb :smear-cursor.nvim
    {:event :DeferredUIEnter
     :after (setup- :smear_cursor
                    {:smear_between_buffers true
                     :smear_between_neighbor_lines true
                     :scroll_buffer_space true
                     :smear_insert_mode true})})
