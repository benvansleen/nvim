(import-macros {: config : setup} :macros)

(setup :nixCatsUtils {:non_nix_value true})
(config (requires [:config]))
