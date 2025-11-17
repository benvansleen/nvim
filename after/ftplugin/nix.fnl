(import-macros {: cfg} :macros)

(vim.api.nvim_set_hl 0 "@punctuation.delimiter.nix" {:link :NonText})
(cfg (bo {expandtab true shiftwidth 2 softtabstop 2 tabstop 2}))
