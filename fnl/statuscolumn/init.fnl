(import-macros {: cfg : with-require} :macros)

(cfg (opt {statuscolumn (with-require {column :statuscolumn.setup}
                          column.activate)}))
