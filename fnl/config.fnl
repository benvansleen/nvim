(import-macros {: autoload : cfg : with-require : unless-nix} :macros)

(local big-file-max-bytes (* 1024 1024))
(local big-file-max-lines 10000)

(fn disable-expensive-features [buf]
  (when (vim.api.nvim_buf_is_valid buf)
    (tset (. vim.b buf) :big_file true)
    (vim.diagnostic.enable false {:bufnr buf})
    (vim.lsp.inlay_hint.enable false {:bufnr buf})
    (vim.lsp.semantic_tokens.enable false {:bufnr buf})
    (pcall vim.treesitter.stop buf)))

(let [big-file-group (vim.api.nvim_create_augroup :big-file-policy
                                                  {:clear true})]
  (cfg (autocmd {[:BufReadPre] {:group big-file-group
                                :callback (fn [{: buf : file}]
                                            (when (> (vim.fn.getfsize file)
                                                     big-file-max-bytes)
                                              (disable-expensive-features buf)))}
                 [:BufReadPost] {:group big-file-group
                                 :callback (fn [{: buf}]
                                             (when (> (vim.api.nvim_buf_line_count buf)
                                                      big-file-max-lines)
                                               (disable-expensive-features buf)))}})))

(cfg (g {mapleader " "
         maplocalleader ","
         my_center_buffer true
         _debug_my_center_buffer false
         loaded_matchit 1
         netrw_liststyle 0
         netrw_banner 0})
     (requires-plugins :appearance :completion :debug :editor :format :git
                       :helm :lint :lisp :lisette :lsp :misc :opencode :pairs
                       :oil :telescope :terminal :tmux :treesitter)
     (requires :clipboard :gui :lsp :statuscolumn :theme)
     (opt {autoindent true
           autoread true
           backupcopy :yes
           breakindent true
           cursorline true
           expandtab true
           fillchars {:eob " "}
           hlsearch true
           ignorecase true
           inccommand :split
           laststatus 0
           linebreak true
           list true
           listchars {:tab "  " :trail "·" :nbsp "␣"}
           mouse :a
           number false
           relativenumber false
           ruler false
           scrolloff 10
           shiftround true
           shiftwidth 2
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
           tabstop 2
           termguicolors true
           timeoutlen 300
           updatetime 250
           undofile true
           winborder :shadow})
     (map {[[:n :v] "Scroll up" :<C-j>] :<C-d>zz
           [[:n :v] "Scroll down" :<C-k>] :<C-u>zz})
     (nmap {["Clear highlights" :<Esc>] :<cmd>nohlsearch<CR>
            ["[W]hat's [T]his [F]ile?" :<leader>wtf] #(print (vim.api.nvim_buf_get_name 0))
            ["[Q]uit buffer" :<leader>q] vim.cmd.bdelete
            ["Forcefully [Q]uit buffer" :<leader>Q] #(vim.cmd :bdelete!)
            ["[H]ighlight [U]nder [C]ursor" :<leader>huc] :<cmd>Inspect<CR>
            ["Comment line" :<M-/>] #(vim.cmd.normal :gcc)})
     (imap {["Exit Insert Mode" :jj] :<Esc>})
     (vmap {["Move lines down" :J] ":m '>+1<CR>gv=gv"
            ["Move lines up" :K] ":m '>-2<CR>gv=gv"})
     (tmap {["Exit Terminal Insert Mode" :<Esc>] "<C-\\><C-n>"})
     (autocmd {[:BufWinEnter] {:desc "return cursor to where it was last time file was closed"
                               :pattern "*"
                               :command "silent! normal! g`\"zv"}
               [:TextYankPost] {:group (vim.api.nvim_create_augroup :highlight
                                                                    {:clear true})
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
