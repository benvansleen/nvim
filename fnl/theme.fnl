(import-macros {: autoload : setup : with-require} :macros)
(autoload core :nfnl.core)

(fn update-hl [group opts]
  (let [cur-hl (vim.api.nvim_get_hl 0 {:name group})]
    (if cur-hl.link
        (tail! (update-hl cur-hl.link opts))
        (core.merge cur-hl opts))))

(local hl (partial vim.api.nvim_set_hl 0))
(local theme-name :gruvbox-material)
(local contrast :medium)
(local palette (with-require {colors :gruvbox-material.colors}
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
        :customize (partial customize-colors palette)})

(let [{: bg0} palette
      italic-nontext (update-hl :NonText {:italic true})]
  (hl :WinBar (update-hl :NonText italic-nontext))
  (hl :WinBarNC (update-hl :NonText italic-nontext))
  (hl :StatusLine {:bg bg0})
  (hl :StatusLineNC {:bg bg0})
  (hl :CursorLine {:bg bg0}))

(fn set-telescope-highlights []
  (let [{: bg4 : blue : bg_yellow} palette
        {:bg0 dark-hard-bg0} (with-require {colors :gruvbox-material.colors}
                               (colors.get vim.o.background :hard))]
    (hl :TelescopePromptNormal {:bg bg4 :link nil})
    (hl :TelescopePromptBorder {:fg bg4 :bg bg4 :link nil})
    (hl :TelescopeNormal {:bg dark-hard-bg0 :link nil})
    (hl :TelescopeResultsNormal {:bg dark-hard-bg0 :link nil})
    (hl :TelescopePreviewNormal {:bg dark-hard-bg0 :link nil})
    (hl :TelescopeSelection {:bold true :bg bg4 :link nil})
    (hl :TelescopeBorder {:fg dark-hard-bg0 :bg dark-hard-bg0 :link nil})
    (hl :TelescopePromptTitle {:fg bg4 :bg bg_yellow :link nil})
    (hl :TelescopeResultsTitle {:fg bg4 :bg blue :link nil})
    (hl :TelescopePreviewTitle {:link :TelescopeResultsTitle})))

{: set-telescope-highlights : update-hl}
