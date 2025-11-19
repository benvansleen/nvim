(import-macros {: autoload : cfg : dot-repeatable} :macros)

(autoload {: toggle-fstring : toggle-expand-args} :lib.python)

(dot-repeatable repeatable-toggle-expand-args #(toggle-expand-args))
(dot-repeatable repeatable-toggle-fstring #(toggle-fstring))

(cfg (g {python_indent {:continue "shiftwidth()"
                        :open_paren "shiftwidth()"
                        :nested_paren "shiftwidth()"
                        :closed_paren_align_last_line false}})
     (bo {expandtab true shiftwidth 4 softtabstop 4 tabstop 4})
     (nmap {["[T]oggle [f]-string" :<localleader>tf] repeatable-toggle-fstring
            ["[T]oggle expanded [A]rguments" :<localleader>ta] repeatable-toggle-expand-args
            ["Set python repl" :<localleader>cp] #(set vim.g.conjure#client#python#stdio#command
                                                       (vim.fn.input "Python repl: "
                                                                     vim.g.conjure#client#python#stdio#command))})
     (imap {["Toggle [f]-string" :<M-f>] #(toggle-fstring)}))
