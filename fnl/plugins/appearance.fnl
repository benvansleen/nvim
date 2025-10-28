(import-macros {: tb} :macros)


(let [theme-name :gruvbox-material
      theme (require theme-name)
      contrast "medium"
      colors ((. (require :gruvbox-material.colors) "get") 
              vim.o.background
              contrast)]
  (theme.setup 
    {:italics true
     : contrast 
     :comments {:italics true}
     :background {:transparent false}
     :customize (fn [g o]
                 (when (or (= g "TelescopeBorder")
                           (= g "TelescopeNormal")
                           (= g "TelescopePromptNormal")
                           (= g "TelescopePromptBorder")
                           (= g "TelescopePromptTitle")
                           (= g "TelescopePreviewTitle")
                           (= g "TelescopeResultsTitle"))
                   (set o.link nil)
                   (set o.bg colors.bg0)
                   (set o.fg colors.bg0))
                 o)}))

(tb "smear-cursor.nvim"
    {:event "DeferredUIEnter"
     :after (fn [_]
              (let [smear (require :smear_cursor)]
                (smear.setup 
                  {:smear_between_buffers true
                   :smear_between_neighbor_lines true
                   :scroll_buffer_space true
                   :smear_insert_mode true})))})
