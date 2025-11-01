(import-macros {: with-require} :macros)

(fn nearest-parent-of-type [node-type node]
  (fn climb-tree [node]
    (if (or (not node) (= (node:type) node-type))
        node
        (tail! (climb-tree (node:parent)))))

  (climb-tree (or node (with-require {ts-utils :nvim-treesitter.ts_utils}
                         (ts-utils.get_node_at_cursor)))))

{: nearest-parent-of-type}
