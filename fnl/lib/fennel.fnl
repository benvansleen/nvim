(fn get-associated-file []
  (case (vim.fn.expand "%:e")
    :lua (-> "%:p"
             vim.fn.expand
             (string.gsub "%.lua" "%.fnl")
             (string.gsub :/lua/ :/fnl/))
    :fnl (-> "%:p"
             vim.fn.expand
             (string.gsub "%.fnl" "%.lua")
             (string.gsub :/fnl/ :/lua/))))

(comment (get-associated-file))

(fn cmd-on-associated-file [cmd]
  (-> (get-associated-file)
      (->> (.. cmd " "))
      vim.cmd))

(comment (cmd-on-associated-file :edit))

{: cmd-on-associated-file}
