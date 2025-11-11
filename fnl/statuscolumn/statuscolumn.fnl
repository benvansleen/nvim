(import-macros {: autoload : define : require-and-call} :macros)
(autoload core :nfnl.core)
(define M :statuscolumn.statuscolumn)

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
                           :gitcommit
                           :NeogitStatus
                           :NeogitDiffView
                           :startuptime
                           :toggleterm
                           :TelescopePrompt]
                   (require-and-call :statuscolumn.border :border)))

(fn M.center-buffer [buf-ft]
  (disable-for-fts buf-ft [:NeogitDiffView
                           :NeogitStatus
                           :NeogitPopup
                           :TelescopePrompt]
                   (require-and-call :statuscolumn.center-buffer :center-buffer
                                     buf-ft)))

(fn M.folds [buf-ft]
  (disable-for-fts buf-ft [:dap-repl
                           :dap-view
                           :dap-view-term
                           :NeogitDiffView
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
                       (disable-for-fts buf-ft [:TelescopePrompt] "%l")
                       " "]) "")))

(fn M.activate []
  "%!v:lua.require('statuscolumn.setup').init()")

M
