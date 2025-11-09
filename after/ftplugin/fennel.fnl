(import-macros {: autoload : cfg : dot-repeatable} :macros)
(autoload utils :lib.fennel)

(dot-repeatable edit-associated-file #(utils.cmd-on-associated-file :edit))

(cfg (nmap {["Toggle to compiled lua file" :<leader>do] edit-associated-file
            ["Toggle to compiled lua file in split" :<leader>dO] #(utils.cmd-on-associated-file :vsplit)}))
