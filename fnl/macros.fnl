;; [nfnl-macro]

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

(fn config [...]
  (fn set-require [opts]
    (icollect [_ req (pairs opts)]
      `(require ,req)))

  (fn set-options [opts]
    (icollect [k v (pairs opts)]
      `(tset vim.opt ,(tostring k) ,v)))

  (fn set-global [opts]
    (icollect [k v (pairs opts)]
      `(tset vim.g ,(tostring k) ,v)))

  (fn set-mappings [mode mappings]
    (icollect [k v (pairs mappings)]
      `(vim.keymap.set ,mode ,k ,v)))

  (fn set-autocmds [cmds]
    (icollect [events cfg (pairs cmds)]
      `(vim.api.nvim_create_autocmd ,events ,cfg)))

  `(do
     ,(unpack (icollect [k v (pairs ...)]
                (case [(tostring k) v]
                  [:requires reqs] (set-require reqs)
                  [:opt opts] (set-options opts)
                  [:g opts] (set-global opts)
                  [:nmap mappings] (set-mappings :n mappings)
                  [:imap mappings] (set-mappings :i mappings)
                  [:vmap mappings] (set-mappings :v mappings)
                  [:autocmd cmds] (set-autocmds cmds)
                  _ (error (.. "Unknown config form: " (view k))))))))

{: tb
 : with-require
 : with-require-
 : require-and-call
 : setup
 : setup-
 : config}
