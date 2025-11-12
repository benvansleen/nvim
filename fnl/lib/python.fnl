(import-macros {: autoload : define : when-let : with-preserve-position}
               :macros)

(autoload str :nfnl.string)
(autoload lib :lib.treesitter)
(autoload {: any : insert-line-break-same-indent : reversed} :lib.utils)
(define M :lib.python)

(fn M.toggle-fstring []
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

;; fnlfmt: skip
(fn M.expand-args [node]
  (let [children (icollect [child (node:iter_children)] child)]
    (when (> (length children) 2)
      (each [i child (reversed children)]
        (case (child:type)
          "," nil

          (where opening (or (= opening "(") (= opening "[") (= opening "{")))
          (do
            (lib.goto-node-end child)
            (vim.cmd.normal (.. :=i opening)))

          (where (or ")" "]" "}"))
          (do
            (lib.goto-node-end child)
            (insert-line-break-same-indent
              (let [prev-node-type (-> children (. (- i 1)) (: :type))]
                (if (any (partial = prev-node-type) ["," :for_in_clause :if_clause])
                    ""
                    ","))))
          _ (do
              (lib.goto-node-start child)
              (insert-line-break-same-indent)))))))

(fn M.collapse-args [srow erow]
  (let [lines (vim.api.nvim_buf_get_lines 0 (- srow 1) erow false)
        [hd & tl] lines
        text (table.concat tl " ")
        cleaned (-> text
                    (: :gsub "[%s]+" " ")
                    (: :gsub "%(%s" "(")
                    (: :gsub ",?%s%)" ")")
                    (: :gsub ",?%s%]" "]")
                    (: :gsub ",?%s%}" "}"))
        final (.. (str.trimr hd) (str.triml cleaned))]
    (vim.api.nvim_buf_set_lines 0 (- srow 1) erow false [final])))

(local expandable-types [:list
                         :dictionary
                         :tuple
                         :list_comprehension
                         :dictionary_comprehension
                         :set_comprehension
                         :generator_expression
                         :argument_list
                         :parameters])

;; fnlfmt: skip
(fn M.toggle-expand-args []
  (when-let [node
             (lib.nearest-parent-until #(let [node-type ($1:type)]
                                          (any (partial = node-type)
                                               expandable-types)))]
    (let [(srow _scol erow _ecol) (lib.range-of-node node)]
      (lib.goto-node-start node)
      (with-preserve-position [_win _cursor]
        (if (= srow erow)
            (M.expand-args node)
            (M.collapse-args srow erow))))))

M
