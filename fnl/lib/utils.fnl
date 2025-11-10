(import-macros {: autoload : define} :macros)
(autoload core :nfnl.core)
(autoload str :nfnl.string)
(define M :lib.utils)

(fn M.all [pred xs]
  (core.reduce (fn [acc x] (and acc (pred x))) true xs))

(comment (M.all #(> $1 0) [1 2 3])
  (M.all #(> $1 0) [1 -2 3]))

(fn M.reversed [arr]
  (fn reverse [arr i]
    (local i (- i 1))
    (if (not= i 0)
        (values i (. arr i))))

  (values reverse arr (+ (length arr) 1)))

(comment (icollect [x (M.reversed [1 2 3 4])]
           x))

(fn M.insert-line-break-same-indent [chars]
  (let [line (vim.api.nvim_get_current_line)
        [row col] (vim.api.nvim_win_get_cursor 0)
        before (line:sub 1 col)
        after (line:sub (+ col 1))
        indent (or (line:match "^(%s*)") "")]
    (vim.api.nvim_set_current_line (.. (str.trimr before) (or chars "")))
    (vim.api.nvim_buf_set_lines 0 row row true [(.. indent after)])))

(comment (M.insert-line-break-same-indent ")"))

M
