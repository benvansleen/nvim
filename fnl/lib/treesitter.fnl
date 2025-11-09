(import-macros {: define : require-and-call} :macros)
(define M :lib.treesitter)

(fn M.nearest-parent-of-type [node-type node]
  (fn climb-tree [node]
    (if (or (not node) (= (node:type) node-type))
        node
        (tail! (climb-tree (node:parent)))))

  (climb-tree (or node
                  (require-and-call :nvim-treesitter.ts_utils
                                    :get_node_at_cursor))))

M
