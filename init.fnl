(import-macros {: cfg : setup : unless-nix : when-nix : with-require} :macros)

(vim.loader.enable)

(set vim.g.nix_info_plugin_name (or vim.g.nix_info_plugin_name :__NOT_NIX__))
(let [(ok nixInfo) (pcall require vim.g.nix_info_plugin_name)]
  (set _G.nixInfo nixInfo)
  (when (not ok)
    (tset package.loaded vim.g.nix_info_plugin_name
          (setmetatable {} {:__call (fn [_ default] default)}))
    (set _G.nixInfo (require vim.g.nix_info_plugin_name))))

;; TODO: require module w/ `vim.pack` to manage plugin installation in non-nix setups

(set _G.nixInfo.isNix (not= vim.g.nix_info_plugin_name nil))
(set _G.nixInfo.lze
     (setmetatable (require :lze) (getmetatable (require :lzextras))))

(fn _G.nixInfo.get_nix_plugin_path [name]
  (or (_G.nixInfo nil :plugins :lazy name)
      (_G.nixInfo nil :plugins :start name)))

(_G.nixInfo.lze.register_handlers [{:spec_field :auto_enable
                                    :set_lazy false
                                    :modify (fn [plugin]
                                              (when vim.g.nix_info_plugin_name
                                                (case (type plugin.auto_enable)
                                                  :table (each [_ name (pairs plugin.auto_enable)]
                                                           (when (not (_G.nixInfo.get_nix_plugin_path name))
                                                             (set plugin.enabled
                                                                  false)))
                                                  :string (when (not (_G.nixInfo.get_nix_plugin_path plugin.auto_enable))
                                                            (set plugin.enabled
                                                                 false))
                                                  (where :boolean
                                                         plugin.auto_enable)
                                                  (when (not (_G.nixInfo.get_nix_plugin_path plugin.name))
                                                    (set plugin.enabled false))))
                                              plugin)}
                                   {:spec_field :for_cat
                                    :set_lazy false
                                    :modify (fn [plugin]
                                              (when (and vim.g.nix_info_plugin_name
                                                         (= (type plugin.for_cat)
                                                            :string))
                                                (set plugin.enabled
                                                     (_G.nixInfo false
                                                                 :settings :cats
                                                                 plugin.for_cat)))
                                              plugin)}
                                   _G.nixInfo.lze.lsp])

(_G.nixInfo.lze.h.lsp.set_ft_fallback (fn [name]
                                        (let [lspcfg (_G.nixInfo.get_nix_plugin_path :nvim-lspconfig)]
                                          (if lspcfg
                                              (let [(ok config) (pcall dofile
                                                                       (.. lspcfg
                                                                           :/lsp/
                                                                           name
                                                                           :.lua))]
                                                (or (. (and ok (or config {}))
                                                       :filetypes)
                                                    {}))))))

(cfg (requires :config))
