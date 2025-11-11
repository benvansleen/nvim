(import-macros {: cfg : setup : unless-nix : when-nix : with-require} :macros)

(cfg (nmap {["[L]oad non-nix [P]ackage manager" " LP"] #(do
                                                          (require :non_nix_download)
                                                          (vim.cmd.PaqSync))}))

(when-nix (vim.loader.enable))
(setup :nixCatsUtils {:non_nix_value true})
(cfg (requires :config))
