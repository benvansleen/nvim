(import-macros {: autoload : cfg : with-require} :macros)
(autoload {: all} :lib.utils)

(fn run-linters [{: try_lint : linters_by_ft}]
  (when (all #(= (vim.fn.executable $1) 1) (. linters_by_ft vim.bo.filetype))
    (try_lint))
  (when (= (vim.fn.executable :typos) 1)
    (try_lint :typos)))

(cfg (plugins [:nvim-lint
               {:for_cat {:cat :lint :default false}
                :event :BufWritePre
                :after #(with-require {: lint}
                          (set lint.linters_by_ft
                               {:fennel [:fennel]
                                :nix [:deadnix :nix :statix]
                                :rust [:clippy]
                                :python [:ruff]})
                          (cfg (autocmd {[:BufWritePost] {:callback #(run-linters lint)}})))}]))
