(import-macros {: cfg : define : require-and-call : with-require} :macros)
(define M :lsp.on-attach)

(fn M.on_attach [client bufnr]
  (vim.diagnostic.config {:signs {:text {vim.diagnostic.severity.ERROR ""
                                         vim.diagnostic.severity.WARN ""
                                         vim.diagnostic.severity.INFO ""
                                         vim.diagnostic.severity.HINT ""}
                                  :numhl {vim.diagnostic.severity.ERROR :ErrorMsg
                                          vim.diagnostic.severity.WARN :WarningMsg}}})
  (vim.lsp.inlay_hint.enable true nil bufnr)
  (with-require {: nvim-navic}
    (nvim-navic.attach client bufnr)
    (cfg (wo {winbar "%{%v:lua.require'nvim-navic'.get_location()%}"})))
  (cfg (nmap {["[R]e[n]ame" :<leader>rn] vim.lsp.buf.rename
              ["[C]ode [A]ction" :<leader>ca] vim.lsp.buf.code_action
              ["[G]oto [D]efinition" :gd] vim.lsp.buf.definition
              ["[G]oto [D]eclaration" :gD] vim.lsp.buf.declaration
              ["Type [D]efinition" :<leader>D] vim.lsp.buf.type_definition
              ["Hover Documentation" :K] vim.lsp.buf.hover
              ["[W]orkspace [A]dd Folder" :<leader>wa] vim.lsp.buf.add_workspace_folder
              ["[W]orkspace [R]emove Folder" :<leader>wr] vim.lsp.buf.remove_workspace_folder
              ["[W]orkspace [L]ist Folders" :<leader>wl] #(-> (vim.lsp.buf.list_workspace_folders)
                                                              vim.inspect
                                                              print)})
       (imap {["Signature Documentation" :<C-k>] vim.lsp.buf.signature_help}))
  (vim.api.nvim_buf_create_user_command bufnr :Format #(vim.lsp.buf.format)
                                        {:desc "Format current buffer with LSP"})
  (when (nixCats :general.telescope)
    (cfg (nmap {["[G]oto [D]efinitions" :gd] #(require-and-call :telescope.builtin
                                                                :lsp_definitions)
                ["[G]oto [R]eferences" :gr] #(require-and-call :telescope.builtin
                                                               :lsp_references)
                ["[G]oto [I]mplementation" :gI] #(require-and-call :telescope.builtin
                                                                   :lsp_implementations)
                ["[D]ocument [S]ymbols" :<leader>ds] #(require-and-call :telescope.builtin
                                                                        :lsp_document_symbols)
                ["[W]orkspace [S]ymbols" :<leader>ws] #(require-and-call :telescope.builtin
                                                                         :lsp_dynamic_workspace_symbols)}))))

M
