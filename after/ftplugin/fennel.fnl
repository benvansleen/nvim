(import-macros {: config} :macros)

(fn get-associated-filepath []
  (-> "%:p"
      vim.fn.expand
      (string.gsub "%.fnl" "%.lua")
      (string.gsub :/fnl/ :/lua/)))

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
      "Toggle to compiled lua file")

(nmap :<leader>dO (cmd-on-associated-filepath :vsplit)
      "Toggle to compiled lua file in split")
