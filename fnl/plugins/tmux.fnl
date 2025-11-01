(import-macros {: tb : setup- : require-and-call-} :macros)

(tb :Navigator.nvim
    {:for_cat :general.tmux
     :on_require :Navigator
     :keys [(tb :<A-k> (require-and-call- :Navigator :up)
                {:mode [:n :t] :desc "Navigate up"})
            (tb :<A-j> (require-and-call- :Navigator :down)
                {:mode [:n :t] :desc "Navigate down"})
            (tb :<A-h> (require-and-call- :Navigator :left)
                {:mode [:n :t] :desc "Navigate left"})
            (tb :<A-l> (require-and-call- :Navigator :right)
                {:mode [:n :t] :desc "Navigate right"})]
     :after (setup- :Navigator {:auto_save nil :disable_on_zoom true})})
