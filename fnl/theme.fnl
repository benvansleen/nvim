(import-macros {: autoload : cfg : define : setup : with-require} :macros)
(autoload core :nfnl.core)
(define M :theme)

(fn M.update-hl [group opts]
  (let [cur-hl (vim.api.nvim_get_hl 0 {:name group})]
    (if cur-hl.link
        (tail! (M.update-hl cur-hl.link opts))
        (core.merge cur-hl opts))))

(local hl (partial vim.api.nvim_set_hl 0))
(local theme-name :gruvbox-material)
(local contrast :medium)
(set M.palette (with-require {colors :gruvbox-material.colors}
                 (colors.get vim.o.background contrast)))

;; fnlfmt: skip
(fn customize-colors [{: bg0} g o]
  (case g
    (where (or :GreenSign :RedSign :BlueSign :Folded :FoldColumn))
    (do
      (set o.bg bg0)
      o)

    _ o))

(setup theme-name
       {:italics true
        : contrast
        :comments {:italics true}
        :background {:transparent false}
        :customize (partial customize-colors M.palette)})

(let [{: bg0} M.palette
      italic-nontext (M.update-hl :NonText {:italic true})]
  (hl :WinBar (M.update-hl :NonText italic-nontext))
  (hl :WinBarNC (M.update-hl :NonText italic-nontext))
  (hl :StatusLine {:bg bg0})
  (hl :StatusLineNC {:bg bg0})
  (hl :CursorLine {:bg bg0})
  (cfg (autocmd {[:User] {:pattern :TelescopeFindPre
                          :group (vim.api.nvim_create_augroup :reset-cursorline-bg
                                                              {:clear true})
                          :callback #(hl :CursorLine {:bg bg0})}})))

(fn M.set-telescope-highlights []
  (let [{: bg4 : blue : bg_yellow} M.palette
        {:bg0 dark-hard-bg0} (with-require {colors :gruvbox-material.colors}
                               (colors.get vim.o.background :hard))]
    (hl :TelescopePromptNormal {:bg bg4})
    (hl :TelescopeNormal {:bg dark-hard-bg0})
    (hl :TelescopePromptBorder (M.update-hl :TelescopePromptNormal {:fg bg4}))
    (hl :TelescopeBorder (M.update-hl :TelescopeNormal {:fg dark-hard-bg0}))
    (hl :TelescopeResultsNormal (M.update-hl :TelescopeNormal {}))
    (hl :TelescopePreviewNormal {:link :TelescopeResultsNormal})
    (hl :TelescopeSelection (M.update-hl :TelescopePromptNormal {:bold true}))
    (hl :TelescopePromptTitle {:fg bg4 :bg bg_yellow})
    (hl :TelescopeResultsTitle {:fg bg4 :bg blue})
    (hl :TelescopePreviewTitle {:link :TelescopeResultsTitle})))

M
