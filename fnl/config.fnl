(import-macros {: config} :macros)

(let [lze (require :lze)
      lzUtils (require :nixCatsUtils.lzUtils)
      lzextras (require :lzextras)]
  (lze.register_handlers lzUtils.for_cat)
  (lze.register_handlers lzextras.lsp))

;; fnlfmt: skip
(let [numbertoggle-g (vim.api.nvim_create_augroup :numbertoggle {})
      highlight-g (vim.api.nvim_create_augroup :highlight {})
      screen-width (vim.api.nvim_win_get_width 0)
      statuscolumn "  %l%s%C"
      statuscolumn-wide (.. (string.rep " " (/ (- screen-width 100) 3))
                            statuscolumn)]
  (vim.diagnostic.config {:virtual_lines true})
  (config {g {mapleader " "
              maplocalleader " "
              my_center_buffer false
              netrw_liststyle 0
              netrw_banner 0}

           requires [:lsp
                     :plugins]

            opt {autoindent true
                 breakindent true
                 clipboard "unnamedplus"
                 expandtab true
                 fillchars {:eob " "}
                 hlsearch true
                 inccommand "split"
                 laststatus 0
                 list true
                 listchars {:tab "» "
                            :trail "·"
                            :nbsp "␣"}
                 mouse "a"
                 number false
                 relativenumber false
                 ruler false
                 scrolloff 10
                 shiftround true
                 shiftwidth 4
                 showcmd false
                 showmode false
                 signcolumn :yes
                 smartcase true
                 softtabstop -1
                 statuscolumn statuscolumn
                 statusline "%{repeat('─',winwidth('.'))}"
                 tabstop 4
                 termguicolors true
                 timeoutlen 300
                 updatetime 250
                 undofile true}

           nmap {:<Esc> "<cmd>nohlsearch<CR>"
                 :<C-j> "<C-d>zz"
                 :<C-k> "<C-u>zz"
                 :<leader>tn (fn []
                               (let [cur vim.wo.nu]
                                 (set vim.wo.number (not cur))
                                 (set vim.wo.relativenumber (not cur))))
                 :<leader>tc (fn []
                               (set vim.g.my_center_buffer
                                    (not vim.g.my_center_buffer)))
                 :<leader>te (fn []
                              (let [vt (. (vim.diagnostic.config) "virtual_lines")]
                               (vim.diagnostic.config {:virtual_lines (not vt)})))
                 :<leader>wtf (fn [] (print (vim.api.nvim_buf_get_name 0)))
                 :<leader>q (fn [] (vim.api.nvim_buf_delete 0 {}))}

           imap {:jj :<ESC>}

           vmap {:J ":m '>+1<CR>gv=gv"
                 :K ":m '>-2<CR>gv=gv"}

           autocmd {[:BufWinEnter]
                    {:desc "return cursor to where it was last time file was closed"
                     :pattern "*"
                     :command "silent! normal! g`\"zv"}

                    [:TextYankPost]
                    {:group highlight-g
                     :pattern "*"
                     :callback (fn [] (vim.highlight.on_yank))}

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
                     :callback (fn [] (when vim.wo.nu (set vim.wo.relativenumber false)))}}}))

(when (nixCats :debug)
  (require :myLuaConf.debug))

(when (nixCats :lint)
  (require :lint))

(when (nixCats :format)
  (require :format))
