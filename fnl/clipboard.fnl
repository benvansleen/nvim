(import-macros {: cfg} :macros)

;; https://github.com/LazyVim/LazyVim/discussions/4112
(cfg (opt {clipboard ""}))
(vim.schedule (fn []
                (cfg (opt {clipboard :unnamedplus}))))
