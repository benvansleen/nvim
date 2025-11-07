(import-macros {: require-and-call} :macros)
(local {: autoload : define} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local M (define :statuscolumn {}))

(macro disable-for-fts [ft disabled-fts & body]
  `(if (core.contains? ,disabled-fts ,ft)
       " "
       (do
         ,(unpack body))))

(fn M.border [buf-ft]
  (disable-for-fts buf-ft [:dashboard
                           :dap-repl
                           :dap-view
                           :dap-view-term
                           :NeogitStatus
                           :startuptime
                           :toggleterm
                           :TelescopePrompt]
                   (require-and-call :statuscolumn.border :border)))

(fn M.number [_]
  (let [linenum (if vim.wo.relativenumber
                    (or (and (= vim.v.relnum 0) vim.v.lnum) vim.v.relnum)
                    (if vim.wo.number
                        vim.v.lnum
                        nil))]
    (if (not= linenum nil)
        (string.format "%4d" linenum) "")))

(fn M.center-buffer [buf-ft]
  (disable-for-fts buf-ft [:TelescopePrompt]
                   (require-and-call :statuscolumn.center-buffer :center-buffer
                                     buf-ft)))

(fn M.folds [buf-ft]
  (disable-for-fts buf-ft [:dap-repl
                           :dap-view
                           :dap-view-term
                           :TelescopePrompt
                           :startuptime]
                   (require-and-call :statuscolumn.folds :folds)))

(fn M.signs [buf-ft]
  (disable-for-fts buf-ft [:TelescopePrompt] "%s"))

(fn M.init []
  (let [buf-ft (-> (vim.api.nvim_get_current_buf)
                   (#(vim.api.nvim_get_option_value :filetype {:buf $1})))]
    (or (table.concat [(M.center-buffer buf-ft)
                       (M.signs buf-ft)
                       (M.folds buf-ft)
                       "%l"
                       (M.border buf-ft)
                       " "]) "")))

(set M.activate "%!v:lua.require('statuscolumn.setup').init()")

M
