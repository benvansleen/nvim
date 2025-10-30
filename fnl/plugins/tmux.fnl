(import-macros {: tb : setup- : with-require-} :macros)

(tb :Navigator.nvim
    {:for_cat :general.tmux
     :on_require :Navigator
     :keys [(tb :<A-k> (with-require- [nav :Navigator] (nav.up))
                {:mode [:n :t] :desc "Navigate up"})
            (tb :<A-j> (with-require- [nav :Navigator] (nav.down))
                {:mode [:n :t] :desc "Navigate down"})
            (tb :<A-h> (with-require- [nav :Navigator] (nav.left))
                {:mode [:n :t] :desc "Navigate left"})
            (tb :<A-l> (with-require- [nav :Navigator] (nav.right))
                {:mode [:n :t] :desc "Navigate right"})]
     :after (setup- :Navigator {:auto_save nil :disable_on_zoom true})})
