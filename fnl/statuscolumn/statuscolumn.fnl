(import-macros {: autoload : define} :macros)
(autoload core :nfnl.core)
(autoload {: border} :statuscolumn.border)
(autoload {: center-buffer} :statuscolumn.center-buffer)
(autoload {: folds} :statuscolumn.folds)
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
                           :NeogitStatus
                           :startuptime] (border)))

(fn M.center-buffer [buf-ft]
  (disable-for-fts buf-ft [:NeogitCommitView
                           :NeogitGitCommandHistory
                           :NeogitConsole
                           :NeogitStatus
                           :NeogitPopup]
                   (center-buffer buf-ft)))

(fn M.folds [buf-ft]
  (disable-for-fts buf-ft [:dap-repl :dap-view :dap-view-term :startuptime]
                   (folds buf-ft)))

(fn M.signs [buf-ft]
  (disable-for-fts buf-ft [] "%s"))

(fn M.lines [buf-ft]
  (disable-for-fts buf-ft [] "%l"))

(fn M.spacing [buf-ft]
  (disable-for-fts buf-ft [] " "))

(fn M.init []
  (fn config [buf-ft]
    (->> [M.center-buffer M.signs M.folds M.lines M.spacing]
         (core.map #($1 buf-ft))
         table.concat))

  (let [buf-ft (vim.api.nvim_get_option_value :filetype
                                              {:buf (tonumber vim.g.actual_curbuf)})]
    (disable-for-fts buf-ft [:gitcommit :TelescopePrompt :NeogitDiffView]
                     (or (config buf-ft) ""))))

(fn M.activate []
  "%{%v:lua.require('statuscolumn.setup').init()%}")

M
