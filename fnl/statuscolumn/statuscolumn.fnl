(import-macros {: require-and-call} :macros)

(local statuscolumn {})

(macro disable-for-fts [ft disabled-fts & body]
  `(if (vim.tbl_contains ,disabled-fts ,ft)
       " "
       (do
         ,(unpack body))))

(fn statuscolumn.border [buf-ft]
  (disable-for-fts buf-ft [:dashboard
                           :dap-repl
                           :dap-view
                           :dap-view-term
                           :NeogitStatus
                           :startuptime
                           :toggleterm
                           :TelescopePrompt]
                   (require-and-call :statuscolumn.border :border)))

(fn statuscolumn.number [_]
  (let [linenum (if vim.wo.relativenumber
                    (or (and (= vim.v.relnum 0) vim.v.lnum) vim.v.relnum)
                    (if vim.wo.number
                        vim.v.lnum
                        nil))]
    (if (not= linenum nil)
        (string.format "%4d" linenum) "")))

(fn statuscolumn.center-buffer [buf-ft]
  (disable-for-fts buf-ft [:TelescopePrompt]
                   (require-and-call :statuscolumn.center-buffer :center-buffer
                                     buf-ft)))

(fn statuscolumn.folds [buf-ft]
  (disable-for-fts buf-ft [:dap-repl
                           :dap-view
                           :dap-view-term
                           :TelescopePrompt
                           :startuptime]
                   (require-and-call :statuscolumn.folds :folds)))

(fn statuscolumn.signs [buf-ft]
  (disable-for-fts buf-ft [:TelescopePrompt] "%s"))

(fn statuscolumn.init []
  (let [buf-ft (-> (vim.api.nvim_get_current_buf)
                   (#(vim.api.nvim_get_option_value :filetype {:buf $1})))]
    (or (table.concat [(statuscolumn.center-buffer buf-ft)
                       (statuscolumn.signs buf-ft)
                       (statuscolumn.folds buf-ft)
                       "%l"
                       (statuscolumn.border buf-ft)
                       " "]) "")))

(set statuscolumn.activate "%!v:lua.require('statuscolumn.setup').init()")

statuscolumn
