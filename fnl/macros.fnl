;; [nfnl-macro]

;; from https://github.com/Olical/dotfiles/blob/dabf3678b48d6857ad01a8f7d2e274ac48fc37f2/stowed/.config/nvim/fnl/config/macros.fnl#L3
(fn tb [& args]
  "
  Mixed sequential and associative tables at compile time.
  Meaning: {'pkg', {opt1 = 'value'}}
  "
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

(fn with-preserve-position [[window cursor] & body]
  `(let [,window (vim.api.nvim_get_current_win)
         ,cursor (vim.api.nvim_win_get_cursor ,window)]
     ,(unpack body)
     (vim.api.nvim_win_set_cursor ,window ,cursor)))

(fn require-and-call [mod f opts]
  (if opts
      `((. (require ,mod) ,f) ,opts)
      `((. (require ,mod) ,f))))

(fn setup [req opts]
  (if opts
      `(let [p# (require ,req)]
         (p#.setup ,opts))
      `(let [p# (require ,req)]
         (p#.setup))))

(fn config [& body]
  (fn set-require [opts]
    (icollect [_ req (pairs opts)]
      `(require ,req)))

  (fn load-plugins-when-enabled [ms]
    (icollect [_ m (ipairs ms)]
      `(when (nixCats ,m)
         (import-macros {: load-plugins} :macros)
         (load-plugins ,m))))

  (fn set-opt [t opts]
    (icollect [k v (pairs opts)]
      `(tset ,t ,(tostring k) ,v)))

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
        [:load-plugins-when-enabled] (load-plugins-when-enabled body)
        [:g] (set-opt `vim.g body)
        [:opt] (set-opt `vim.opt body)
        [:wo] (set-opt `vim.wo body)
        [:bo] (set-opt `vim.bo body)
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

(fn dot-repeatable [name f]
  (let [name# (-> name
                  tostring
                  (string.gsub "-" "_")
                  (->> (.. "__")))
        luaname (.. "v:lua." name#)]
    `(local ,name (do
                    (tset _G ,name# ,f)
                    (fn []
                      (tset vim.o :operatorfunc ,luaname)
                      (vim.cmd.normal "g@l"))))))

(fn is-nix []
  `(do
     (import-macros {: with-require} :macros)
     (with-require {cats# :nixCatsUtils}
       cats#.isNixCats)))

(fn check-nix [bool & body]
  `(do
     (import-macros {: is-nix} :macros)
     (when (= ,bool (is-nix))
       ,(unpack body))))

(fn unless-nix [...]
  (check-nix false ...))

(fn when-nix [...]
  (check-nix true ...))

{: config
 : dot-repeatable
 : is-nix
 : load-plugins
 : require-and-call
 : setup
 : tb
 : unless-nix
 : when-let
 : when-nix
 : with-preserve-position
 : with-require}
