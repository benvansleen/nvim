(import-macros {: config} :macros)

;; fnlfmt: skip
(let [numbertoggle-g (vim.api.nvim_create_augroup :numbertoggle {})]
  (config (nmap {:<leader>tn (fn []
                               (let [cur vim.wo.nu]
                                 (set vim.wo.number (not cur))
                                 (set vim.wo.relativenumber (not cur))))})
          (autocmd {[:BufEnter :FocusGained :InsertLeave :CmdlineLeave :WinEnter]
                    {:pattern "*"
                     :group numbertoggle-g
                     :once false
                     :nested false
                     :callback (fn []
                                 (when (and vim.wo.nu
                                            (not= :i (. (vim.api.nvim_get_mode) :mode)))
                                   (set vim.wo.relativenumber true)))}

                    [:BufLeave :FocusLost :InsertEnter :CmdlineEnter :WinLeave]
                    {:pattern "*"
                     :group numbertoggle-g
                     :once false
                     :nested false
                     :callback (fn [] (when vim.wo.nu (set vim.wo.relativenumber false)))}})))
