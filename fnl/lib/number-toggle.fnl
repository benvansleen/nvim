(import-macros {: cfg : define} :macros)
(define M :number-toggle)

(fn M.activate-relative-number []
  (when (and vim.wo.nu (not= :i (. (vim.api.nvim_get_mode) :mode)))
    (cfg (wo {relativenumber true}))))

(fn M.disable-relative-number []
  (when vim.wo.nu
    (cfg (wo {relativenumber false}))))

(fn M.toggle []
  (let [toggled (not vim.wo.nu)]
    (cfg (wo {number toggled relativenumber toggled}))))

(set M.group (vim.api.nvim_create_augroup :numbertoggle {:clear true}))
(set M.autocmd-toggle-on [:InsertLeave :CmdlineLeave])
(set M.autocmd-toggle-off [:InsertEnter :CmdlineEnter])

M
