(import-macros {: setup : with-require} :macros)

(fn update-hl [group opts]
  (let [cur-hl (vim.api.nvim_get_hl 0 {:name group})]
    (if cur-hl.link
        (tail! (update-hl cur-hl.link opts))
        (vim.tbl_extend :force cur-hl opts))))

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

(fn set-telescope-highlights []
  (let [{: bg4} palette
        dark-hard "#1d2021"
        hl #(vim.api.nvim_set_hl 0 $1 $2)]
    (hl :TelescopePromptNormal {:bg bg4 :link nil})
    (hl :TelescopePromptBorder {:fg bg4 :bg bg4 :link nil})
    (hl :TelescopeNormal {:bg dark-hard :link nil})
    (hl :TelescopeSelection {:bold true :bg bg4 :link nil})
    (hl :TelescopeBorder {:fg dark-hard :bg dark-hard :link nil})
    (hl :TelescopePromptTitle {:fg bg4 :bg palette.blue :link nil})
    (hl :TelescopeResultsTitle {:fg bg4 :bg palette.green :link nil})
    (hl :TelescopePreviewTitle {:link :TelescopeResultsTitle})))

{: set-telescope-highlights : update-hl}
