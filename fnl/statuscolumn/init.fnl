(import-macros {: autoload : cfg : with-require} :macros)
(autoload column :statuscolumn.setup)

(cfg (opt {statuscolumn column.activate}))
