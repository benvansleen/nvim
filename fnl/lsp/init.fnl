(import-macros {: autoload : cfg : is-nix : setup : tb : with-require} :macros)
(local {: on_attach} (require :lsp.on-attach))

(with-require {: lze}
  (let [old_ft_fallback (lze.h.lsp.get_ft_fallback)]
    (when (and (is-nix) (nixCats :lspDebugMode))
      (vim.lsp.set_log_level :debug))
    (lze.h.lsp.set_ft_fallback (fn [name]
                                 (let [lspcfg (or (nixCats.pawsible [:allPlugins
                                                                     :opt
                                                                     :nvim-lspconfig])
                                                  (nixCats.pawsible [:allPlugins
                                                                     :start
                                                                     :nvim-lspconfig]))]
                                   (if lspcfg
                                       (let [[ok config] (pcall dofile
                                                                (.. lspcfg
                                                                    :/lsp/ name
                                                                    :.lua))
                                             return (fn [ok config]
                                                      (or (. (and ok config)
                                                             :filetypes)
                                                          {}))]
                                         (if ok
                                             (return ok config)
                                             (let [[ok config] (pcall dofile
                                                                      (.. lspcfg
                                                                          :/lua/lspconfig/configs/
                                                                          name
                                                                          :.lua))]
                                               (return ok config))))
                                       (old_ft_fallback name)))))
    (cfg (plugins [:nvim-lspconfig
                   {:for_cat :general.always
                    :on_require [:lspconfig]
                    :lsp (fn [plugin]
                           (vim.lsp.config plugin.name (or plugin.lsp {}))
                           (vim.lsp.enable plugin.name))
                    :before #(vim.lsp.config "*"
                                             {: on_attach
                                              :root_markers [:.git]})}]
                  [:lazydev.nvim
                   {:for_cat :neonixdev
                    :cmd [:LazyDev]
                    :ft [:lua]
                    :after #(setup :lazydev
                                   {:library {:words [:nixCats]
                                              :path (.. (or nixCats.nixCatsPath
                                                            "")
                                                        :/lua)}})}]
                  [:lua_ls
                   {:enabled (or (nixCats :lua) (nixCats :neonixdev) false)
                    :ft [:lua]
                    :lsp {:filetypes [:lua]
                          :settings {:Lua {:runtime {:version :LuaJIT}
                                           :formatters {:ignoreComments true}
                                           ; :codeLens {:enable true}
                                           :signatureHelp {:enabled true}
                                           :diagnostics {:globals [:nixCats
                                                                   :vim]
                                                         :disable [:missing-fields]}
                                           :telemetry {:enabled false}}}}}]
                  [:fennel_ls
                   {:enabled (or (nixCats :fnl) false)
                    :ft [:fennel]
                    :lsp {:filetypes [:fennel] :settings {}}}]
                  [:rnix
                   {:enabled (not (is-nix))
                    :ft [:nix]
                    :lsp {:filetypes [:nix]}}]
                  [:nil_ls
                   {:enabled (not (is-nix))
                    :ft [:nix]
                    :lsp {:filetypes [:nix]}}]
                  [:nixd
                   {:enabled (and (is-nix)
                                  (or (nixCats :nix) (nixCats :neonixdev) false))
                    :ft [:nix]
                    :lsp {:filetypes [:nix]
                          :cmd_env {:NIX_PATH "nixpkgs=flake:nixpkgs"}
                          :settings {:nixd {:nixpkgs {:expr (or (nixCats.extra :nixdExtras.nixpkgs)
                                                                "import <nixpkgs> {}")}}
                                     :options {:nixos {:expr (nixCats.extra :nixdExtras.nixos_options)}
                                               :home-manager {:expr (nixCats.extra :nixdExtras.home_manager_options)}}
                                     :formatting {:command [:nixfmt]}
                                     :diagnostic {:suppress [:sema-escaping-with]}}}}]
                  [:basedpyright
                   {:enabled (or (nixCats :python) false)
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
                  [:ts_ls
                   {:enabled (or (nixCats :typescript) false)
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
                          : on_attach}}]))))
