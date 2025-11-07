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

(fn cfg [& body]
  (fn set-require [opts]
    (icollect [_ req (pairs opts)]
      `(require ,req)))

  (fn require-plugins [plugins]
    (set-require (icollect [_ p (ipairs plugins)]
                   (.. :plugins. p))))

  (fn set-opt [t opts]
    (icollect [k v (pairs opts)]
      (let [k (tostring k)
            kind (string.sub k -1)]
        (case kind
          "+" `(: (. ,t ,(string.sub k 1 -2)) :append ,v)
          _ `(tset ,t ,k ,v)))))

  (fn set-mappings [keymap mode mappings]
    (fn set-map [keymap mode kb action desc]
      `((. ,keymap :set) ,mode ,kb ,action {:noremap true :desc ,desc}))

    (icollect [key action (pairs mappings)]
      (if mode
          (set-map keymap mode (. key 2) action (. key 1))
          (set-map keymap (. key 1) (. key 3) action (. key 2)))))

  (fn set-autocmds [cmds]
    (icollect [events cfg (pairs cmds)]
      `(vim.api.nvim_create_autocmd ,events ,cfg)))

  (fn keys [t]
    (let [result []]
      (each [k _ (pairs t)]
        (table.insert result k))
      result))

  (fn count [t] (length (keys t)))

  (fn configure-plugin [[name spec & mappings]]
    (let [spec# (if (> (count spec) 0) spec nil)
          keymap `(do
                    (import-macros {: require-and-call : tb} :macros)
                    (require-and-call :lzextras :keymap (tb ,name ,spec#)))]
      `(let [keymap# ,keymap]
         ,(icollect [_ [kw mapping] (ipairs mappings)]
            (let [mode (case (tostring kw)
                         :nmap :n
                         :imap :i
                         :vmap :v
                         :map nil)]
              (set-mappings `keymap# mode mapping))))))

  (icollect [_ [kw & body] (ipairs body)]
    (do
      (case (tostring kw)
        :requires (set-require body)
        :requires-plugins (require-plugins body)
        :requires-plugins-when-enabled (icollect [_ p (ipairs body)]
                                         `(when (nixCats ,p)
                                            (require ,(.. :plugins. p))))
        :g (set-opt `vim.g (unpack body))
        :opt (set-opt `vim.opt (unpack body))
        :wo (set-opt `vim.wo (unpack body))
        :bo (set-opt `vim.bo (unpack body))
        :map (set-mappings `vim.keymap nil (unpack body))
        :nmap (set-mappings `vim.keymap :n (unpack body))
        :imap (set-mappings `vim.keymap :i (unpack body))
        :vmap (set-mappings `vim.keymap :v (unpack body))
        :autocmd (set-autocmds (unpack body))
        :plugins (icollect [_ p (ipairs body)]
                   (configure-plugin p))
        _ (error (.. "Unknown config form: " (view kw)))))))

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

{: cfg
 : dot-repeatable
 : is-nix
 : require-and-call
 : setup
 : tb
 : unless-nix
 : when-let
 : when-nix
 : with-preserve-position
 : with-require}
