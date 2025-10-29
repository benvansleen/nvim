(import-macros {: tb : setup- : with-require} :macros)

(with-require [cats :nixCatsUtils lze :lze]
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
                                              {:on_attach (require :lsp.on_attach)}))})
               (tb :mason.nvim
                   {:enabled (not cats.isNixCats)
                    :on_plugin [:nvim-lspconfig]
                    :load (fn [name]
                            (vim.cmd.packadd name)
                            (vim.cmd.packadd :mason-lspconfig.nvim)
                            ((. (require :mason) :setup))
                            ((. (require :mason-lspconfig) :setup) {:automatic_installation false}))})
               (tb :lazydev.nvim
                   {:for_cat :neonixdev
                    :cmd [:LazyDev]
                    :ft [:lua]
                    :after (setup- :lazydev
                                   {:library {:words [:nixCats]
                                              :path (.. (or nixCats.nixCatsPath
                                                            "")
                                                        :/lua)}})})
               (tb :lua_ls
                   {:enabled (or (nixCats :lua) (nixCats :neonixdev) false)
                    :lsp {:filetypes [:lua]
                          :settings {:Lua {:runtime {:version :LuaJIT}
                                           :formatters {:ignoreComments true}
                                           :signatureHelp {:enabled true}
                                           :diagnostics {:globals [:nixCats
                                                                   :vim]
                                                         :disable [:missing-fields]}
                                           :telemetry {:enabled false}}}}})
               (tb :fennel_ls
                   {:for_cat :fnl :lsp {:filetypes [:fennel] :settings {}}})
               (tb :rnix {:enabled (not cats.isNixCats)
                          :lsp {:filetypes [:nix]}})
               (tb :nil_ls
                   {:enabled (not cats.isNixCats) :lsp {:filetypes [:nix]}})
               (tb :nixd
                   {:enabled (and cats.isNixCats
                                  (or (nixCats :nix) (nixCats :neonixdev) false))
                    :lsp {:filetypes [:nix]
                          :settings {:nixd {:nixpkgs {:expr (or (nixCats.extra :nixdExtras.nixpkgs)
                                                                "import <nixpkgs> {}")}
                                            :options {:nixos {:expr (nixCats.extra :nixdExtras.nixos_options)}
                                                      :home-manager {:expr (nixCats.extra :nixdExtras.home_manager_options)}}
                                            :formatting {:command [:nixfmt]}
                                            :diagnostic {:suppress [:sema-escaping-with]}}}}})])))
