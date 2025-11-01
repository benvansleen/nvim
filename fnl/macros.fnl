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

(fn when-let [[sym expr] & body]
  `(let [,sym ,expr]
     (when ,sym
       ,(unpack body))))

(fn with-require [bindings & body]
  (let [pairings (accumulate [l [] sym mod (pairs bindings)]
                   (do
                     (table.insert l (if (= :string (type sym)) mod sym))
                     (table.insert l `(require ,(tostring mod)))
                     l))]
    `(let ,pairings
       (do
         ,(unpack body)))))

(fn with-require- [...]
  (let [form (with-require ...)]
    `(fn [] ,form)))

(fn with-preserve-position [[window cursor] & body]
  `(let [,window (vim.api.nvim_get_current_win)
         ,cursor (vim.api.nvim_win_get_cursor ,window)]
     ,(unpack body)
     (vim.api.nvim_win_set_cursor ,window ,cursor)))

(fn require-and-call [mod f opts]
  (if opts
      `((. (require ,mod) ,f) ,opts)
      `((. (require ,mod) ,f))))

(fn require-and-call- [...] ; (print ...)
  (let [form (require-and-call ...)] ; (print (view form))
    `(fn [] ,form)))

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
    (icollect [[desc k] v (pairs mappings)]
      `(vim.keymap.set ,mode ,k ,v {:noremap true :desc ,desc})))

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
       (import-macros {: require-and-call} :macros)
       (require-and-call :lze :load ,imports))))

{: tb
 : when-let
 : with-require
 : with-require-
 : with-preserve-position
 : require-and-call
 : require-and-call-
 : setup
 : setup-
 : config
 : load-plugins}
