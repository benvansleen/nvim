(import-macros {: cfg : is-nix : nix-config : nix-enabled} :macros)

(local {: on_attach} (require :lsp.on-attach))

(vim.diagnostic.config {:signs {:text {vim.diagnostic.severity.ERROR ""
                                       vim.diagnostic.severity.WARN ""
                                       vim.diagnostic.severity.INFO ""
                                       vim.diagnostic.severity.HINT ""}
                                :numhl {vim.diagnostic.severity.ERROR :ErrorMsg
                                        vim.diagnostic.severity.WARN :WarningMsg}}})

(cfg (plugins [:nvim-lspconfig
               {:for_cat :lsp
                :lsp (fn [plugin]
                       (vim.lsp.config plugin.name (or plugin.lsp {}))
                       (vim.lsp.enable plugin.name))}]
              [:lua_ls
               {:enabled (or (nix-enabled :lua) false)
                :ft [:lua]
                :lsp {:filetypes [:lua]
                      :settings {:Lua {:runtime {:version :LuaJIT}
                                       :formatters {:ignoreComments true}
                                       ; :codeLens {:enable true}
                                       :signatureHelp {:enabled true}
                                       :diagnostics {:globals [:vim]
                                                     :disable [:missing-fields]}
                                       :telemetry {:enabled false}}}
                      : on_attach}}]
              [:fennel_ls
               {:enabled (or (nix-enabled :fennel) false)
                :ft [:fennel]
                :lsp {:filetypes [:fennel] : on_attach}}]
              [:nixd
               {:enabled (and (is-nix) (or (nix-enabled :nix) false))
                :ft [:nix]
                :lsp {:filetypes [:nix]
                      :cmd_env {:NIX_PATH "nixpkgs=flake:nixpkgs"}
                      :settings {:nixd {:nixpkgs {:expr (or (nix-config :settings
                                                                        :nixdNixpkgsPath)
                                                            "import <nixpkgs> {}")}}
                                 :options {:nixos {:expr (nix-config :settings
                                                                     :nixdNixosPath)}
                                           :home-manager {:expr (nix-config :settings
                                                                            :nixdHomeManagerPath)}}
                                 :formatting {:command [:nixfmt]}
                                 :diagnostic {:suppress [:sema-escaping-with]}}
                      : on_attach}}]
              [:basedpyright
               {:enabled false
                :ft [:python]
                :lsp {:filetypes [:python]
                      :settings {:basedpyright {:analysis {:useTypingExtensions true
                                                           :inlayHints {:variableTypes true
                                                                        :callArgumentNames true
                                                                        :functionReturnTypes true
                                                                        :genericTypes true}
                                                           :autoImportCompletions true
                                                           :diagnosticSeverityOverrides {:reportMissingTypeStubs false}}}}
                      : on_attach}}]
              [:ty
               {:enabled (or (nix-enabled :python) false)
                :ft [:python]
                :lsp {:filetypes [:python] :cmd [:ty :server] : on_attach}}]
              [:ts_ls
               {:enabled (or (nix-enabled :typescript) false)
                :ft [:typescript]
                :lsp {:filetypes [:javascript
                                  :javascriptreact
                                  :typescript
                                  :typescriptreact]
                      :settings {}
                      : on_attach}}]
              [:rust_analyzer
               {:enabled (or (nix-enabled :rust) false)
                :ft [:rust]
                :lsp {:filetypes [:rust]
                      :settings {:rust-analyzer {:diagnostics {:enable true}
                                                 :check {:command :clippy}}}
                      : on_attach}}]
              [:nu_ls
               {:enabled (or (nix-enabled :nu) false)
                :ft [:nu]
                :lsp {:filetypes [:nu] :cmd [:nu :--lsp] : on_attach}}]
              [:svelte
               {:enabled (or (nix-enabled :typescript) false)
                :ft [:svelte]
                :lsp {:filetypes [:svelte] : on_attach}}]
              [:gopls
               {:enabled (or (nix-enabled :go) false)
                :ft [:go]
                :lsp {:filetypes [:go :gomod :gowork :gotmpl] : on_attach}}]
              [:helm_ls
               {:enabled (or (nix-enabled :helm) false)
                :ft [:helm :yaml.helm-values]
                :lsp {:filetypes [:helm :yaml.helm-values]
                      :root_markers [:Chart.yaml]
                      : on_attach}}]
              [:terraformls
               {:enabled (or (nix-enabled :terraform) false)
                :ft [:terraform :terraform-vars]
                :lsp {:filetypes [:terraform :terraform-vars] : on_attach}}]
              [:postgres_lsp
               {:enabled (or (nix-enabled :postgres) false)
                :ft [:sql]
                :lsp {:filetypes [:sql] : on_attach}}]))
