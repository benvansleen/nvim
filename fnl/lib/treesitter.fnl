(import-macros {: autoload : define} :macros)
(autoload {: get_node_at_cursor : get_vim_range} :nvim-treesitter.ts_utils)
(define M :lib.treesitter)

(fn M.nearest-parent-until [p-fn node]
  (fn climb-tree [node]
    (if (or (not node) (p-fn node))
        node
        (tail! (climb-tree (node:parent)))))

  (climb-tree (or node (get_node_at_cursor))))

(fn M.nearest-parent-of-type [node-type node]
  (M.nearest-parent-until #(= ($1:type) node-type) node))

(fn M.range-of-node [node]
  (get_vim_range [(node:range)]))

(fn M.goto-node [end? node]
  (let [(srow scol erow ecol) (M.range-of-node node)]
    (vim.fn.setcursorcharpos (if end? [erow ecol] [srow scol]))
    (values srow scol ecol erow)))

(set M.goto-node-start (partial M.goto-node false))
(set M.goto-node-end (partial M.goto-node true))

(comment (vim.inspect (getmetatable (M.nearest-parent-of-type :string)))
  (let [node (M.nearest-parent-of-type :let_form)
        (srow scol _ecol _erow) (M.range-of-node node)]
    (vim.fn.setcursorcharpos [srow scol]))
  (let [node (M.nearest-parent-of-type :let_form)]
    (M.goto-node-end node))
  (let [node (M.nearest-parent-of-type :let_form)]
    (icollect [child (node:iter_children)]
      child)))

M
