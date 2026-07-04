(import-macros {: cfg : update-hl-for-fts} :macros)

(local {: on_attach} (require :lsp.on-attach))

(vim.filetype.add {:extension {:lis :lisette}})

(fn setup-lisette []
  (let [plugin-dir (_G.nixInfo.get_nix_plugin_path :lisette-nvim)
        nvim-dir (.. plugin-dir :/editors/nvim)
        parser-src (.. plugin-dir :/editors/tree-sitter-lisette/src)
        parser-dir (.. (vim.fn.stdpath :data) :/lisette/parser)
        parser-so (.. parser-dir :/lisette.so)]
    (vim.opt.rtp:append nvim-dir)

    (fn parser-is-stale []
      (if (= (vim.fn.isdirectory parser-src) 0)
          false
          (let [so-time (vim.fn.getftime parser-so)]
            (if (= so-time -1)
                true
                (let [src-time (math.max (vim.fn.getftime (.. parser-src
                                                              :/parser.c))
                                         (vim.fn.getftime (.. parser-src
                                                              :/scanner.c)))]
                  (> src-time so-time))))))

    (when (parser-is-stale)
      (vim.fn.mkdir parser-dir :p)
      (let [result (vim.fn.system [:cc
                                   :-o
                                   parser-so
                                   :-I
                                   parser-src
                                   (.. parser-src :/parser.c)
                                   (.. parser-src :/scanner.c)
                                   :-shared
                                   :-Os
                                   :-fPIC])]
        (when (not= vim.v.shell_error 0)
          (vim.notify (.. "Failed to compile Lisette tree-sitter parser:\n"
                          result) vim.log.levels.WARN))))
    (when (= (vim.fn.filereadable parser-so) 1)
      (vim.treesitter.language.add :lisette {:path parser-so})

      (fn start-lisette-treesitter [{: buf}]
        (when (= (. vim.bo buf :filetype) :lisette)
          (when (pcall vim.treesitter.start buf :lisette)
            (tset (. vim.bo buf) :indentexpr
                  "v:lua.require'nvim-treesitter'.indentexpr()"))))

      (vim.api.nvim_create_autocmd :FileType
                                   {:group (vim.api.nvim_create_augroup :UserLisetteTreesitter
                                                                        {:clear true})
                                    :pattern :lisette
                                    :callback start-lisette-treesitter})
      (each [_ buf (ipairs (vim.api.nvim_list_bufs))]
        (when (vim.api.nvim_buf_is_loaded buf)
          (start-lisette-treesitter {: buf}))))
    (let [lsp-config (dofile (.. nvim-dir :/lsp/lisette.lua))]
      (tset lsp-config :on_attach on_attach)
      (vim.lsp.config :lisette lsp-config))
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
