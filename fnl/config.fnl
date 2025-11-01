(import-macros {: config : load-plugins : with-require} :macros)

(with-require {: lze : lzextras lzUtils :nixCatsUtils.lzUtils}
  (lze.register_handlers lzUtils.for_cat)
  (lze.register_handlers lzextras.lsp))

;; fnlfmt: skip
(let [highlight-g (vim.api.nvim_create_augroup :highlight {})]
  (config (g {mapleader " "
              maplocalleader " "
              my_center_buffer true
              _debug_my_center_buffer false
              netrw_liststyle 0
              netrw_banner 0})
          (requires [:clipboard :lsp :lib :plugins])
          (opt {autoindent true
                breakindent true
                expandtab true
                fillchars {:eob " "}
                hlsearch true
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
                showcmd false
                showmode false
                signcolumn :yes
                smartcase true
                showtabline 0
                softtabstop -1
                splitbelow true
                splitright true
                statuscolumn "  %l%s%C"
                statusline "%{repeat('─',winwidth('.'))}"
                tabstop 4
                termguicolors true
                timeoutlen 300
                updatetime 250
                undofile true})
          (nmap {["Clear highlights" :<Esc>] :<cmd>nohlsearch<CR>
                 ["Scroll down" :<C-j>] :<C-d>zz
                 ["Scroll up" :<C-k>] :<C-u>zz
                 ["[T]oggle virtual lines" :<leader>te] (fn []
                                                         (let [vt (. (vim.diagnostic.config)
                                                                     :virtual_lines)]
                                                           (vim.diagnostic.config {:virtual_lines (not vt)})))
                 ["[W]hat's [T]his [F]ile?" :<leader>wtf] (fn [] (print (vim.api.nvim_buf_get_name 0)))
                 ["[Q]uit buffer" :<leader>q] (fn [] (vim.api.nvim_buf_delete 0 {}))
                 ["[H]ighlight [U]nder [C]ursor" :<leader>huc] :<cmd>Inspect<CR>})
          (imap {["Exit Insert Mode" :jj] :<Esc>})
          (vmap {["Move lines down" :J] ":m '>+1<CR>gv=gv"
                 ["Move lines up" :K] ":m '>-2<CR>gv=gv"})
          (autocmd {[:BufWinEnter] {:desc "return cursor to where it was last time file was closed"
                                    :pattern "*"
                                    :command "silent! normal! g`\"zv"}
                    [:TextYankPost] {:group highlight-g
                                     :pattern "*"
                                     :callback (fn [] (vim.highlight.on_yank))}})))

(when (nixCats :center-buffer)
  (require :center-buffer))

(when (nixCats :number-toggle)
  (require :number-toggle))

(when (nixCats :debug)
  (load-plugins :debug))

(when (nixCats :lint)
  (require :lint))

(when (nixCats :format)
  (require :format))

(with-require {: nixCatsUtils}
  (when (not nixCatsUtils.isNixCats)
    (config (nmap {["Scroll Up" :<up>] :<C-u> ["Scroll Down" :<down>] :<C-d>}))))
