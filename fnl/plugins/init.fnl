(import-macros {: cfg} :macros)

(cfg (requires-plugins :appearance :completion :editor :git :lisp :lsp :misc
                       :oil :telescope :terminal :tmux :treesitter)
     (requires-plugins-when-enabled :debug :lint :format))
