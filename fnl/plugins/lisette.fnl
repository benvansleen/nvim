(import-macros {: cfg : update-hl-for-fts} :macros)

(local {: on_attach} (require :lsp.on-attach))

(vim.filetype.add {:extension {:lis :lisette}})

(fn setup-lisette []
  (let [plugin-dir (_G.nixInfo.get_nix_plugin_path :lisette-nvim)
        nvim-dir (.. plugin-dir :/editors/nvim)
        lsp-config (dofile (.. nvim-dir :/lsp/lisette.lua))]
    (vim.opt.rtp:append nvim-dir)
    (tset lsp-config :on_attach on_attach)
    (vim.lsp.config :lisette lsp-config)
    (vim.lsp.enable :lisette)))

(update-hl-for-fts [:lisette]
                   {"@punctuation.bracket" {:link :NonText}
                    "@punctuation.special" {:link "@string"}
                    "@punctuation.delimiter" {:link :NonText}
                    "@function.call" {:italic true}
                    "@function.method.call" {:italic true}
                    "@module.builtin" {:bold true}})

(cfg (plugins [:lisette-nvim
               {:for_cat :lisette :ft :lisette :after setup-lisette}]))
