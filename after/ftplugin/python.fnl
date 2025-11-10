(import-macros {: autoload
                : cfg
                : dot-repeatable
                : require-and-call
                : when-let
                : with-preserve-position} :macros)

(autoload str :nfnl.string)
(autoload lib :lib.treesitter)
(autoload {: insert-line-break-same-indent : reversed} :lib.utils)

(fn toggle-fstring []
  (with-preserve-position [_ cursor]
    (let [node (lib.nearest-parent-of-type :string)]
      (if (not node)
          (print "f-string-toggle: could not detect string at point")
          (let [(srow scol _ecol _erow) (lib.goto-node-start node)
                line (vim.api.nvim_get_current_line)
                char (line:sub scol scol)]
            (if (= char :f)
                (do
                  (vim.cmd.normal :x)
                  (when (= srow (. cursor 1))
                    (tset cursor 2 (- (. cursor 2) 1))))
                (do
                  (vim.cmd.normal :if)
                  (when (= srow (. cursor 1))
                    (tset cursor 2 (+ (. cursor 2) 1))))))))))

(comment (autoload core :nfnl.core)
  (let [node (lib.nearest-parent-of-type :let_form)
        children (icollect [child (node:iter_children)]
                   child)
        reversed-children (icollect [_ child (reversed children)]
                            child)]
    (print (. children 1))
    (print (vim.inspect reversed-children))
    (core.map #($1:type) reversed-children)))

(fn expand-args [node]
  (let [children (icollect [child (node:iter_children)] child)]
    (each [i child (reversed children)]
      (case (child:type)
        "," nil
        "(" (do
              (lib.goto-node-end child)
              (vim.cmd.normal "=i)")
              (vim.cmd.normal "g@l"))
        ")" (do
              (lib.goto-node-end child)
              (insert-line-break-same-indent (if (= ","
                                                    (-> children
                                                        (. (- i 1))
                                                        (: :type)))
                                                 ""
                                                 ",")))
        _ (do
            (lib.goto-node-start child)
            (insert-line-break-same-indent))))))

(fn collapse-args [srow erow]
  (let [lines (vim.api.nvim_buf_get_lines 0 (- srow 1) erow false)
        [hd & tl] lines
        text (table.concat tl " ")
        cleaned (-> text
                    (: :gsub "[%s]+" " ")
                    (: :gsub ",%s%)" ")"))
        final (.. (str.trimr hd) (str.triml cleaned))]
    (vim.api.nvim_buf_set_lines 0 (- srow 1) erow false [final])))

(fn toggle-expand-args []
  (when-let [node (lib.nearest-parent-of-type :argument_list)]
            (let [(srow _scol erow _ecol) (lib.range-of-node node)]
              (lib.goto-node-start node)
              (with-preserve-position [_win _cursor]
                (if (= srow erow)
                    (expand-args node)
                    (collapse-args srow erow))))))

(dot-repeatable repeatable-toggle-expand-args #(toggle-expand-args))

(cfg (bo {shiftwidth 2})
     (nmap {["[T]oggle [f]-string" :<localleader>tf] toggle-fstring
            ["[T]oggle expanded [A]rguments" :<localleader>ta] repeatable-toggle-expand-args})
     (imap {["Toggle [f]-string" :<M-f>] toggle-fstring}))
