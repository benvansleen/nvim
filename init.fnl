(let [nixCatsUtils (require :nixCatsUtils)]
  (nixCatsUtils.setup {:non_nix_value true}))

(require :myLuaConf.non_nix_download)
(require :myLuaConf)

(require :config)

