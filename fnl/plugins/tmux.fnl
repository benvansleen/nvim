(import-macros {: cfg : require-and-call : setup} :macros)

(cfg (plugins [:Navigator.nvim
               {:for_cat :general.tmux
                :on_require :Navigator
                :after #(setup :Navigator
                               {:auto_save nil :disable_on_zoom true})}
               (map {[[:n :t] "Navigate up" :<A-k>] #(require-and-call :Navigator
                                                                       :up)
                     [[:n :t] "Navigate down" :<A-j>] #(require-and-call :Navigator
                                                                         :down)
                     [[:n :t] "Navigate left" :<A-h>] #(require-and-call :Navigator
                                                                         :left)
                     [[:n :t] "Navigate right" :<A-l>] #(require-and-call :Navigator
                                                                          :right)})]))
