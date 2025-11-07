(import-macros {: cfg : setup : when-nix : with-require} :macros)

(when-nix (vim.loader.enable))
(setup :nixCatsUtils {:non_nix_value true})
(cfg (requires :config))
