(import-macros {: config : setup} :macros)

(vim.loader.enable)
(setup :nixCatsUtils {:non_nix_value true})
(config (requires [:config]))
