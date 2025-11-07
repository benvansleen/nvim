(import-macros {: cfg : setup : unless-nix : when-nix : with-require} :macros)

(when-nix (vim.loader.enable))
(setup :nixCatsUtils {:non_nix_value true})
(cfg (nmap {["[L]oad non-nix [P]ackage manager" " LP"] #(unless-nix (require :non_nix_download)
                                                                    (vim.cmd :PaqSync))})
     (requires :config))
