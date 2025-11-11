(import-macros {: autoload : cfg : with-require : unless-nix} :macros)

(with-require {: lze : lzextras lzUtils :nixCatsUtils.lzUtils}
  (lze.register_handlers lzUtils.for_cat)
  (lze.register_handlers lzextras.lsp))

(cfg (g {mapleader " "
         maplocalleader ","
         my_center_buffer true
         _debug_my_center_buffer false
         netrw_liststyle 0
         netrw_banner 0})
     (requires-plugins :appearance :completion :editor :git :lisp :lsp :misc
                       :oil :telescope :terminal :tmux :treesitter)
     (requires-plugins-when-enabled :debug :lint :format)
     (requires :clipboard :lsp :statuscolumn :theme)
     (opt {autoindent true
           breakindent true
           cursorline true
           expandtab true
           fillchars {:eob " "}
           hlsearch true
           ignorecase true
           inccommand :split
           laststatus 0
           list true
           listchars {:tab "» " :trail "·" :nbsp "␣"}
           mouse :a
           number false
           relativenumber false
           ruler false
           scrolloff 10
           shiftround true
           shiftwidth 4
           shortmess+ :I
           showcmd false
           showmode false
           signcolumn :yes
           smartcase true
           showtabline 0
           softtabstop -1
           splitbelow true
           splitright true
           statusline "%{repeat('─',winwidth('.'))}"
           tabstop 4
           termguicolors true
           timeoutlen 300
           updatetime 250
           undofile true
           winborder :shadow})
     (map {[[:n :v] "Scroll up" :<C-j>] :<C-d>zz
           [[:n :v] "Scroll down" :<C-k>] :<C-u>zz})
     (nmap {["Clear highlights" :<Esc>] :<cmd>nohlsearch<CR>
            ["[T]oggle virtual lines" :<leader>te] #(let [vt (. (vim.diagnostic.config)
                                                                :virtual_lines)]
                                                      (vim.diagnostic.config {:virtual_lines (not vt)}))
            ["[W]hat's [T]his [F]ile?" :<leader>wtf] #(print (vim.api.nvim_buf_get_name 0))
            ["[Q]uit buffer" :<leader>q] #(with-require {diffview :diffview.lib}
                                            (if (diffview.get_current_view)
                                                (vim.cmd.DiffviewClose)
                                                (vim.cmd.bdelete)))
            ["Forcefully [Q]uit buffer" :<leader>Q] #(vim.cmd :bdelete!)
            ["[H]ighlight [U]nder [C]ursor" :<leader>huc] :<cmd>Inspect<CR>})
     (imap {["Exit Insert Mode" :jj] :<Esc>})
     (vmap {["Move lines down" :J] ":m '>+1<CR>gv=gv"
            ["Move lines up" :K] ":m '>-2<CR>gv=gv"})
     (autocmd {[:BufWinEnter] {:desc "return cursor to where it was last time file was closed"
                               :pattern "*"
                               :command "silent! normal! g`\"zv"}
               [:TextYankPost] {:group (vim.api.nvim_create_augroup :highlight
                                                                    {})
                                :pattern "*"
                                :callback (fn [] (vim.highlight.on_yank))}}))

(with-require {number-toggle :lib.number-toggle}
  (cfg (nmap {["[T]oggle [n]umbertoggle" :<leader>tn] number-toggle.toggle})
       (autocmd {number-toggle.autocmd-toggle-on {:pattern "*"
                                                  :group number-toggle.group
                                                  :callback number-toggle.activate-relative-number}
                 number-toggle.autocmd-toggle-off {:pattern "*"
                                                   :group number-toggle.group
                                                   :callback number-toggle.disable-relative-number}})))

(unless-nix (cfg (nmap {["Scroll Up" :<up>] :<C-u>
                        ["Scroll Down" :<down>] :<C-d>})))
