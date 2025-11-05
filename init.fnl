(import-macros {: config : setup : when-nix} :macros)

(when-nix (vim.loader.enable))
(setup :nixCatsUtils {:non_nix_value true})
(config (requires [:config]))
