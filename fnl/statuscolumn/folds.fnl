(import-macros {: define} :macros)
(define M :statuscolumn.folds)

(fn _G.click_handler []
  (vim.cmd "normal! za"))

(fn M.folds []
  (let [foldlevel (vim.fn.foldlevel vim.v.lnum)
        foldlevel-before (vim.fn.foldlevel (or (and (>= (- vim.v.lnum 1) 1)
                                                    (- vim.v.lnum 1))
                                               (- vim.v.lnum 1)))
        foldlevel-after (vim.fn.foldlevel (or (and (<= (+ vim.v.lnum 1)
                                                       (vim.fn.line "$"))
                                                   (+ vim.v.lnum 1))
                                              (vim.fn.line "$")))
        foldclosed (vim.fn.foldclosed vim.v.lnum)]
    (.. "%@v:lua.click_handler@"
        (if (or (not= vim.v.virtnum 0) (= foldlevel 0))
            " "
            (if (and (not= foldclosed -1) (= foldclosed vim.v.lnum))
                "▶"
                (if (> foldlevel foldlevel-before) "▽"
                    (if (> foldlevel foldlevel-after) "╰" "│")))))))

M
