(import-macros {: setup : tb : with-require} :macros)

(with-require {cats :nixCatsUtils : lze}
  (let [old_ft_fallback (lze.h.lsp.get_ft_fallback)]
    (when (and cats.isNixCats (nixCats :lspDebugMode))
      (vim.lsp.set_log_level :debug))
    (lze.h.lsp.set_ft_fallback (fn [name]
                                 (let [lspcfg (or (nixCats.pawsible [:allPlugins
                                                                     :opt
                                                                     :nvim-lspconfig])
                                                  (nixCats.pawsible [:allPlugins
                                                                     :start
                                                                     :nvim-lspconfig]))]
                                   (if lspcfg
                                       (let [[ok cfg] (pcall dofile
                                                             (.. lspcfg :/lsp/
                                                                 name :.lua))
                                             return (fn [ok cfg]
                                                      (or (. (and ok cfg)
                                                             :filetypes)
                                                          {}))]
                                         (if ok
                                             (return ok cfg)
                                             (let [[ok cfg] (pcall dofile
                                                                   (.. lspcfg
                                                                       :/lua/lspconfig/configs/
                                                                       name
                                                                       :.lua))]
                                               (return ok cfg))))
                                       (old_ft_fallback name)))))
    (lze.load [(tb :nvim-lspconfig
                   {:for_cat :general.always
                    :on_require [:lspconfig]
                    :lsp (fn [plugin]
                           (vim.lsp.config plugin.name (or plugin.lsp {}))
                           (vim.lsp.enable plugin.name))
                    :before (fn [_]
                              (vim.lsp.config "*"
                                              {:on_attach (require :lsp.on_attach)
                                               :root_markers [:.git]}))})
               (tb :mason.nvim
                   {:enabled (not cats.isNixCats)
                    :on_plugin [:nvim-lspconfig]
                    :load (fn [name]
                            (vim.cmd.packadd name)
                            (vim.cmd.packadd :mason-lspconfig.nvim)
                            (setup :mason)
                            (setup :mason-lspconfig
                                   {:automatic_installation false}))})
               (tb :lazydev.nvim
                   {:for_cat :neonixdev
                    :cmd [:LazyDev]
                    :ft [:lua]
                    :after #(setup :lazydev
                                   {:library {:words [:nixCats]
                                              :path (.. (or nixCats.nixCatsPath
                                                            "")
                                                        :/lua)}})})
               (tb :lua_ls
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
                                           :telemetry {:enabled false}}}}})
               (tb :fennel_ls
                   {:enabled (or (nixCats :fnl) false)
                    :ft [:fennel]
                    :lsp {:filetypes [:fennel] :settings {}}})
               (tb :rnix {:enabled (not cats.isNixCats)
                          :ft [:nix]
                          :lsp {:filetypes [:nix]}})
               (tb :nil_ls
                   {:enabled (not cats.isNixCats)
                    :ft [:nix]
                    :lsp {:filetypes [:nix]}})
               (tb :nixd
                   {:enabled (and cats.isNixCats
                                  (or (nixCats :nix) (nixCats :neonixdev) false))
                    :ft [:nix]
                    :lsp {:filetypes [:nix]
                          :cmd_env {:NIX_PATH "nixpkgs=flake:nixpkgs"}
                          :settings {:nixd {:nixpkgs {:expr (or (nixCats.extra :nixdExtras.nixpkgs)
                                                                "import <nixpkgs> {}")}}
                                     :options {:nixos {:expr (nixCats.extra :nixdExtras.nixos_options)}
                                               :home-manager {:expr (nixCats.extra :nixdExtras.home_manager_options)}}
                                     :formatting {:command [:nixfmt]}
                                     :diagnostic {:suppress [:sema-escaping-with]}}}})
               (tb :basedpyright
                   {:enabled (or (nixCats :python) false)
                    :ft [:python]
                    :lsp {:filetypes [:python]
                          :settings {:basedpyright {:analysis {:useTypingExtensions true
                                                               :inlayHints {:variableTypes true
                                                                            :callArgumentNames true
                                                                            :functionReturnTypes true
                                                                            :genericTypes true}
                                                               :diagnosticSeverityOverrides {:reportMissingTypeStubs false}}}}
                          :on_attach (require :lsp.on_attach)}})
               (tb :ts_ls
                   {:enabled (or (nixCats :typescript) false)
                    :ft [:typescript]
                    :lsp {:filetypes [:javascript
                                      :javascriptreact
                                      :typescript
                                      :typescriptreact]
                          :settings {}
                          :on_attach (require :lsp.on_attach)}})
               (tb :rust_analyzer
                   {:enabled true
                    :ft [:rust]
                    :lsp {:filetypes [:rust]
                          :cmd [:rust-analyzer]
                          :settings {:diagnostic {:enable true}
                                     :checkOnSave {:command :clippy}}
                          :on_attach (require :lsp.on_attach)}})])))
