(import-macros {: tb : setup- : require-and-call : config} :macros)

(config (g {loaded_netrwPlugin 1}))

(tb :oil.nvim
    {:for_cat :general.extra
     :cmd [:Oil]
     :keys [(tb "-" :<cmd>Oil<CR>
                {:mode [:n] :noremap true :desc "Open Parent Directory"})
            (tb :<leader>- "<cmd>Oil .<CR>"
                {:mode [:n] :noremap true :desc "Open nvim root directory"})]
     :after (setup- :oil
                    {:default_file_explorer true
                     :view_options {:show_hidden true}
                     :columns [:icon :permissions :size]
                     :keymaps {:g? :actions.show_help
                               :<CR> :actions.select
                               :<C-s> :actions.select_vsplit
                               :<C-h> :actions.select_split
                               :<C-t> :actions.select_tab
                               :<C-p> :actions.preview
                               :<C-c> :actions.close
                               :q :actions.close
                               :<C-l> :actions.refresh
                               :- :actions.parent
                               :_ :actions.open_cwd
                               "`" :actions.cd
                               "~" :actions.tcd
                               :gs :actions.change_sort
                               :gx :actions.open_external
                               :g. :actions.toggle_hidden
                               "g\\" :actions.toggle_trash}})})
