(fn get-associated-filepath []
  (-> "%:p"
      vim.fn.expand
      (string.gsub "%.lua" "%.fnl")
      (string.gsub :/lua/ :/fnl/)))

(macro cmd-on-associated-filepath [cmd]
  `(let [cmd# (-> (get-associated-filepath)
                  (->> (.. ,cmd " ")))]
     (fn [] (vim.cmd cmd#))))

(macro nmap [key f desc]
  `(vim.keymap.set :n ,key ,f {:desc ,desc
                               :noremap true
                               :silent true
                               :buffer true}))

(nmap :<leader>do (cmd-on-associated-filepath :edit)
      "Toggle to parent fnl file")

(nmap :<leader>dO (cmd-on-associated-filepath :vsplit)
      "Toggle to parent fnl file in split")
