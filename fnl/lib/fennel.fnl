(import-macros {: define} :macros)
(define M :lib.fennel)

(fn M.get-associated-file []
  (pick-values 1 (case (vim.fn.expand "%:e")
                   :lua (-> "%:p"
                            vim.fn.expand
                            (string.gsub "%.lua" "%.fnl")
                            (string.gsub :/lua/ :/fnl/))
                   :fnl (-> "%:p"
                            vim.fn.expand
                            (string.gsub "%.fnl" "%.lua")
                            (string.gsub :/fnl/ :/lua/)))))

(comment (M.get-associated-file))

(fn M.cmd-on-associated-file [cmd]
  (-> (M.get-associated-file)
      (->> (.. cmd " "))
      vim.cmd))

(comment (M.cmd-on-associated-file :edit))

M
