(import-macros {: define : require-and-call : with-require} :macros)
(define M :lsp.on-attach)

(fn M.on_attach [client bufnr]
  (vim.diagnostic.config {:virtual_lines {:current_line true}
                          :signs {:text {vim.diagnostic.severity.ERROR ""
                                         vim.diagnostic.severity.WARN ""
                                         vim.diagnostic.severity.INFO ""
                                         vim.diagnostic.severity.HINT ""}
                                  :linehl {vim.diagnostic.severity.ERROR :ErrorMsg}
                                  :numhl {vim.diagnostic.severity.WARN :WarningMsg}}})
  (vim.lsp.inlay_hint.enable true nil bufnr)
  (with-require {: nvim-navic}
    (nvim-navic.attach client bufnr)
    (set vim.wo.winbar "%{%v:lua.require'nvim-navic'.get_location()%}"))

  (fn map [mode keys func desc]
    (vim.keymap.set mode keys func
                    {:buffer bufnr
                     :noremap true
                     :desc (if desc
                               (.. "LSP: " desc)
                               "")}))

  (fn nmap [...] (map :n ...))

  (fn imap [...] (map :i ...))

  (nmap :<leader>rn vim.lsp.buf.rename "[R]e[n]ame")
  (nmap :<leader>ca vim.lsp.buf.code_action "[C]ode [A]ction")
  (nmap :gd vim.lsp.buf.definition "[G]oto [D]efinition")
  (nmap :<leader>D vim.lsp.buf.type_definition "Type [D]efinition")
  (nmap :K vim.lsp.buf.hover "Hover Documentation")
  (imap :<C-k> vim.lsp.buf.signature_help "Signature Documentation")
  (nmap :gD vim.lsp.buf.declaration "[G]oto [D]eclaration")
  (nmap :<leader>wa vim.lsp.buf.add_workspace_folder "[W]orkspace [A]dd Folder")
  (nmap :<leader>wr vim.lsp.buf.remove_workspace_folder
        "[W]orkspace [R]emove Folder")
  (nmap :<leader>wl
        (fn []
          (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
        "[W]orkspace [L]ist Folders")
  (vim.api.nvim_buf_create_user_command bufnr :Format
                                        (fn [_] (vim.lsp.buf.format))
                                        {:desc "Format current buffer with LSP"})
  (when (nixCats :general.telescope)
    (nmap :gd #(require-and-call :telescope.builtin :lsp_definitions)
          "[G]oto [D]efinitions")
    (nmap :gr #(require-and-call :telescope.builtin :lsp_references)
          "[G]oto [R]eferences")
    (nmap :gI #(require-and-call :telescope.builtin :lsp_implementations)
          "[G]oto [I]mplementation")
    (nmap :<leader>ds
          #(require-and-call :telescope.builtin :lsp_document_symbols)
          "[D]ocument [S]ymbols")
    (nmap :<leader>ws
          #(require-and-call :telescope.builtin :lsp_dynamic_workspace_symbols)
          "[W]orkspace [S]ymbols")))

M
