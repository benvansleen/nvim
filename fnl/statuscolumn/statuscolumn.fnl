(import-macros {: autoload : define : require-and-call} :macros)
(autoload core :nfnl.core)
(define M :statuscolumn.statuscolumn)

(macro disable-for-fts [ft disabled-fts & body]
  `(if (core.contains? ,disabled-fts ,ft)
       ""
       (do
         ,(unpack body))))

(fn M.border [buf-ft]
  (disable-for-fts buf-ft [:dashboard
                           :dap-repl
                           :dap-view
                           :dap-view-term
                           :NeogitStatus
                           :startuptime
                           :toggleterm]
                   (require-and-call :statuscolumn.border :border)))

(fn M.center-buffer [buf-ft]
  (disable-for-fts buf-ft [:NeogitStatus :NeogitPopup]
                   (require-and-call :statuscolumn.center-buffer :center-buffer
                                     buf-ft)))

(fn M.folds [buf-ft]
  (disable-for-fts buf-ft [:dap-repl :dap-view :dap-view-term :startuptime]
                   (require-and-call :statuscolumn.folds :folds)))

(fn M.signs [buf-ft]
  (disable-for-fts buf-ft [] "%s"))

(fn M.init []
  (fn config [buf-ft]
    (table.concat [(M.center-buffer buf-ft)
                   (M.signs buf-ft)
                   (M.folds buf-ft)
                   "%l"
                   " "]))

  (let [buf-ft (-> (vim.api.nvim_get_current_buf)
                   (#(vim.api.nvim_get_option_value :filetype {:buf $1})))]
    (disable-for-fts buf-ft [:gitcommit :TelescopePrompt :NeogitDiffView]
                     (or (config buf-ft) ""))))

(fn M.activate []
  "%!v:lua.require('statuscolumn.setup').init()")

M
