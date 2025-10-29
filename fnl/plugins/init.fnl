(import-macros {: with-require} :macros)

(with-require [lze :lze]
  (lze.load [{:import :plugins.appearance}
             {:import :plugins.completion}
             {:import :plugins.editor}
             {:import :plugins.git}
             {:import :plugins.lisp}
             {:import :plugins.oil}
             {:import :plugins.telescope}
             {:import :plugins.treesitter}
             {:import :plugins.tmux}]))
