(vim.keymap.set :n :<leader>do (fn []
                                 (-> "%:p"
                                     vim.fn.expand
                                     (string.gsub "%.fnl" "%.lua")
                                     (string.gsub :/fnl/ :/lua/)
                                     (->> (.. :edit " "))
                                     vim.cmd))
                {:desc "Toggle to compiled lua file"
                 :noremap true
                 :silent true
                 :buffer true})
