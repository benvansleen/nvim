(import-macros {: config} :macros)

(let [lze (require :lze)
      lzUtils (require :nixCatsUtils.lzUtils)
      lzextras (require :lzextras)]
  (lze.register_handlers lzUtils.for_cat)
  (lze.register_handlers lzextras.lsp))

(let [numbertoggle (vim.api.nvim_create_augroup :numbertoggle {})
      screen-width (vim.api.nvim_win_get_width 0)
      statuscolumn "  %l%s%C"
      statuscolumn-wide (.. (string.rep " " (/ (- screen-width 100) 3))
                            statuscolumn)]
  (config {requires [:myLuaConf.opts_and_keys
                     :myLuaConf.plugins
                     :myLuaConf.LSPs
                     :plugins]
           opt {fillchars {:eob " "}
                laststatus 0
                number false
                relativenumber false
                ruler false
                showmode false
                showcmd false
                statuscolumn statuscolumn
                statusline "%{repeat('─',winwidth('.'))}"}
           g {my_center_buffer false}
           nmap {:<leader>tn (fn []
                               (let [cur vim.wo.nu]
                                 (set vim.wo.number (not cur))
                                 (set vim.wo.relativenumber (not cur))))
                 :<leader>tc (fn []
                               (set vim.g.my_center_buffer
                                    (not vim.g.my_center_buffer)))
                 :<leader>wtf (fn [] (print (vim.api.nvim_buf_get_name 0)))
                 :<leader>q (fn [] (vim.api.nvim_buf_delete 0 {}))}
           imap {:jj :<ESC>}
           autocmd {[:BufWinEnter]
                    {:desc "return cursor to where it was last time file was closed"
                     :pattern "*"
                     :command "silent! normal! g`\"zv"}

                    [:BufEnter :BufWinEnter :BufWinLeave :WinEnter :WinLeave :WinResized :VimResized]
                    {:callback (fn []
                                  (let [winwidth (vim.api.nvim_win_get_width 0)]
                                    (if (and vim.g.my_center_buffer
                                             (> winwidth
                                                (/ screen-width
                                                   3)))
                                        (set vim.wo.statuscolumn statuscolumn-wide)
                                        (set vim.wo.statuscolumn statuscolumn))))}

                    [:BufEnter :FocusGained :InsertLeave :CmdlineLeave :WinEnter]
                    {:pattern "*"
                     :group numbertoggle
                     :once false
                     :nested false
                     :callback (fn []
                                 (when (and vim.wo.nu
                                            (not= :i (. (vim.api.nvim_get_mode) :mode)))
                                   (set vim.wo.relativenumber true)))}

                    [:BufLeave :FocusLost :InsertEnter :CmdlineEnter :WinLeave]
                    {:pattern "*"
                     :group numbertoggle
                     :once false
                     :nested false
                     :callback (fn [] (when vim.wo.nu (set vim.wo.relativenumber false)))}}}))

(when (nixCats :debug)
  (require :myLuaConf.debug))

(when (nixCats :lint)
  (require :myLuaConf.lint))

(when (nixCats :format)
  (require :myLuaConf.format))
