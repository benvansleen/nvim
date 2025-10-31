;; [nfnl-macro]

;; from https://github.com/Olical/dotfiles/blob/dabf3678b48d6857ad01a8f7d2e274ac48fc37f2/stowed/.config/nvim/fnl/config/macros.fnl#L3
(fn tb [& args]
  "Mixed sequential and associative tables at compile time. Because the Neovim ecosystem loves them but Fennel has no neat way to express them (which I think is fine, I don't like the idea of them in general)."
  (let [to-merge (when (table? (. args (length args)))
                   (table.remove args))]
    (if to-merge
        (do
          (each [key value (pairs to-merge)]
            (tset args key value))
          args)
        args)))

(fn with-require [bindings & body]
  (let [pairings []]
    (for [i 1 (length bindings) 2]
      (let [sym (. bindings i)
            mod (. bindings (+ i 1))]
        (table.insert pairings sym)
        (table.insert pairings `(require ,mod))))
    `(let ,pairings
       (do
         ,(unpack body)))))

(fn with-require- [...]
  (let [form (with-require ...)]
    `(fn [] ,form)))

(fn require-and-call [mod f opts]
  (if opts
      `(fn []
         ((. (require ,mod) ,f) ,opts))
      `(fn []
         ((. (require ,mod) ,f)))))

(fn setup [req opts]
  (if opts
      `(let [p# (require ,req)]
         (p#.setup ,opts))
      `(let [p# (require ,req)]
         (p#.setup))))

(fn setup- [...]
  (let [setup-form (setup ...)]
    `(fn [] ,setup-form)))

(fn config [& body]
  (fn set-require [opts]
    (icollect [_ req (pairs opts)]
      `(require ,req)))

  (fn set-options [opts]
    (icollect [k v (pairs opts)]
      `(tset vim.opt ,(tostring k) ,v)))

  (fn set-global [opts] ; (print (view opts))
    (icollect [k v (pairs opts)]
      `(tset vim.g ,(tostring k) ,v)))

  (fn set-mappings [mode mappings]
    (icollect [k v (pairs mappings)]
      `(vim.keymap.set ,mode ,k ,v {:noremap true})))

  (fn set-autocmds [cmds]
    (icollect [events cfg (pairs cmds)]
      `(vim.api.nvim_create_autocmd ,events ,cfg)))

  (icollect [_ form (ipairs body)]
    (let [[kw body] form]
      (case [(tostring kw)]
        [:requires] (set-require body)
        [:opt] (set-options body)
        [:g] (set-global body)
        [:nmap] (set-mappings :n body)
        [:imap] (set-mappings :i body)
        [:vmap] (set-mappings :v body)
        [:autocmd] (set-autocmds body)
        _ (error (.. "Unknown config form: " (view kw)))))))

(fn load-plugins [& plugins]
  (let [imports (icollect [_ plugin (ipairs plugins)]
                  {:import (.. :plugins "." plugin)})]
    `(do
       (import-macros {: with-require} :macros)
       (with-require [lze# :lze]
         (lze#.load ,imports)))))

{: tb
 : with-require
 : with-require-
 : require-and-call
 : setup
 : setup-
 : config
 : load-plugins}
