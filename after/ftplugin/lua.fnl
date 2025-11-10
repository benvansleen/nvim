(import-macros {: autoload : cfg : dot-repeatable} :macros)
(autoload {: cmd-on-associated-file} :lib.fennel)

(dot-repeatable edit-associated-file #(cmd-on-associated-file :edit))

(cfg (nmap {["Toggle to parent fnl file" :<leader>do] edit-associated-file
            ["Toggle to parent fnl file in split" :<leader>dO] #(cmd-on-associated-file :vsplit)}))
