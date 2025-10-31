(fn get-associated-filepath []
  (-> "%:p"
      vim.fn.expand
      (string.gsub "%.fnl" "%.lua")
      (string.gsub :/fnl/ :/lua/)))

(fn cmd-on-associated-filepath [cmd]
  (let [cmd (-> (get-associated-filepath)
                (->> (.. cmd " ")))]
    (fn [] (vim.cmd cmd))))

(vim.keymap.set :n :<leader>do (cmd-on-associated-filepath :edit)
                {:desc "Toggle to compiled lua file"
                 :noremap true
                 :silent true
                 :buffer true})

(vim.keymap.set :n :<leader>dO (cmd-on-associated-filepath :vsplit)
                {:desc "Toggle to compiled lua file in split"
                 :noremap true
                 :silent true
                 :buffer true})
