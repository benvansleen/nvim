(import-macros {: cfg : with-require} :macros)

(cfg (plugins [:nvim-lint
               {:for_cat {:cat :lint :default false}
                :event :FileType
                :after #(with-require {: lint}
                          (set lint.linters_by_ft
                               {:fennel [:fennel]
                                :nix [:deadnix :nix :statix]
                                :rust [:clippy]
                                :python [:ruff]})
                          (cfg (autocmd {[:BufWritePost] {:callback #(do
                                                                       (lint.try_lint)
                                                                       (when (= (vim.fn.executable :typos)
                                                                                1)
                                                                         (lint.try_lint :typos)))}})))}]))
