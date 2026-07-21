(import-macros {: autoload
                : cfg
                : is-nix
                : nix-config
                : nix-enabled
                : setup
                : tb
                : with-require} :macros)

(local {: on_attach} (require :lsp.on-attach))

(cfg (plugins [:nvim-lspconfig
               {:for_cat :lsp
                :on_require [:lspconfig]
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
               {:enabled (or (nix-enabled :fnl) false)
                :ft [:fennel]
                :lsp {:filetypes [:fennel] :settings {} : on_attach}}]
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
              [:rust-analyzer
               {:enabled true
                :ft [:rust]
                :lsp {:filetypes [:rust]
                      :cmd [:rust-analyzer]
                      :settings {:diagnostic {:enable true}
                                 :checkOnSave {:command :clippy}}
                      : on_attach}}]
              [:nu_ls
               {:enabled true
                :ft [:nu]
                :lsp {:filetypes [:nu] :cmd [:nu :--lsp] : on_attach}}]
              [:svelte
               {:enabled true
                :ft [:svelte]
                :lsp {:filetypes [:svelte] : on_attach}}]
              [:gopls
               {:enabled true :ft [:go] :lsp {:filetypes [:go] : on_attach}}]
              [:helm_ls
               {:enabled true
                :ft [:helm :helmfile]
                :lsp {:cmd [:helm_ls :serve]
                      :filetypes [:helm :helmfile]
                      :rootPatterns [:Chart.yaml]}
                : on_attach}]
              [:terraform
               {:enabled true
                :ft [:terraform :tf]
                :lsp {:cmd [:terraform-ls :serve]
                      :filetypes [:terraform :tf]
                      : on_attach}}]))
