(import-macros {: config : with-require} :macros)

(config (opt {statuscolumn (with-require {column :statuscolumn.setup}
                             column.activate)}))
