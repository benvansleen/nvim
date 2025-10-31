(vim.keymap.set :n :<leader>do (fn []
                                 (-> "%:p"
                                     vim.fn.expand
                                     (string.gsub "%.lua" "%.fnl")
                                     (string.gsub :/lua/ :/fnl/)
                                     (->> (.. :edit " "))
                                     vim.cmd))
                {:desc "Toggle to fennel file"
                 :noremap true
                 :silent true
                 :buffer true})
