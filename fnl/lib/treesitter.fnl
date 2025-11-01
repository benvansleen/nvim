(import-macros {: require-and-call} :macros)

(fn nearest-parent-of-type [node-type node]
  (fn climb-tree [node]
    (if (or (not node) (= (node:type) node-type))
        node
        (tail! (climb-tree (node:parent)))))

  (climb-tree (or node
                  (require-and-call :nvim-treesitter.ts_utils
                                    :get_node_at_cursor))))

{: nearest-parent-of-type}
