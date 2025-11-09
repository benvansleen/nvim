(import-macros {: cfg} :macros)

(fn activate-relative-number []
  (when (and vim.wo.nu (not= :i (. (vim.api.nvim_get_mode) :mode)))
    (set vim.wo.relativenumber true)))

(fn disable-relative-number []
  (when vim.wo.nu
    (set vim.wo.relativenumber false)))

(local group (vim.api.nvim_create_augroup :numbertoggle {:clear true}))

(cfg (nmap {["[T]oggle [n]umbertoggle" :<leader>tn] #(let [cur vim.wo.nu]
                                                       (set vim.wo.number
                                                            (not cur))
                                                       (set vim.wo.relativenumber
                                                            (not cur)))})
     (autocmd {[:InsertLeave :CmdlineLeave] {:pattern "*"
                                             : group
                                             :once false
                                             :nested false
                                             :callback activate-relative-number}
               [:InsertEnter :CmdlineEnter] {:pattern "*"
                                             : group
                                             :once false
                                             :nested false
                                             :callback disable-relative-number}}))
