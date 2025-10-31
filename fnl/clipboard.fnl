(import-macros {: config} :macros)

;; https://github.com/LazyVim/LazyVim/discussions/4112
(config (opt {clipboard ""}))
(vim.schedule (fn []
                (config (opt {clipboard :unnamedplus}))))
