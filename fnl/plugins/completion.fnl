(import-macros {: cfg : is-nix : setup} :macros)

(macro has-words-before []
  `(let [col# (. (vim.api.nvim_win_get_cursor 0) 2)]
     (if (= col# 0)
         false
         (let [line# (vim.api.nvim_get_current_line)]
           (= (string.match (string.sub line# col# col#) "%s") nil)))))

(cfg (plugins [:blink.cmp
               {:for_cat :blink
                :event [:CmdlineEnter :InsertEnter]
                :after #(setup :blink.cmp
                               {:keymap {:preset :none
                                         :<Tab> [(fn [cmp]
                                                   (when (has-words-before)
                                                     (or (cmp.show)
                                                         (do
                                                           (cmp.hide_documentation)
                                                           (vim.schedule cmp.insert_next)
                                                           true))))
                                                 :fallback]
                                         :<S-Tab> [(fn [cmp]
                                                     (cmp.hide_documentation)
                                                     (vim.schedule cmp.insert_prev)
                                                     true)]
                                         "<M-;>" [(fn [cmp]
                                                    (cmp.accept {:index 1}))]
                                         "<D-;>" [(fn [cmp]
                                                    (cmp.accept {:index 1}))]
                                         :<C-n> [#($1.show {:providers [:ripgrep]})]
                                         :<C-d> [:show_documentation
                                                 :hide_documentation]}
                                :appearance {:nerd_font_variant :normal}
                                :signature {:enabled true
                                            :trigger {:enabled true}
                                            :window {:border vim.o.winborder
                                                     :show_documentation false}}
                                :completion {:documentation {:auto_show false
                                                             :auto_show_delay_ms 1000}
                                             :ghost_text {:enabled true
                                                          :show_with_selection true
                                                          :show_without_selection true
                                                          :show_with_menu true
                                                          :show_without_menu true}
                                             :keyword {:range :prefix}
                                             :list {:selection {:preselect false}
                                                    :cycle {:from_top false}}
                                             :menu {:enabled true
                                                    :border vim.o.winborder
                                                    :scrollbar false
                                                    :auto_show false
                                                    :auto_show_delay_ms 50
                                                    :max_height 7
                                                    :draw {:align_to :label
                                                           :columns [(tb :kind_icon)
                                                                     (tb :label
                                                                         {:gap 1})]
                                                           :components {:label {:text (fn [ctx]
                                                                                        (require-and-call :colorful-menu
                                                                                                          :blink_components_text
                                                                                                          ctx))
                                                                                :highlight (fn [ctx]
                                                                                             (let [highlights (require-and-call :colorful-menu
                                                                                                                                :blink_components_highlight
                                                                                                                                ctx)
                                                                                                   base [0
                                                                                                         (length ctx.label)]]
                                                                                               (when (not= ctx.source_id
                                                                                                           :lsp)
                                                                                                 (tset base
                                                                                                       :group
                                                                                                       :BlinkCmpLabel)
                                                                                                 (table.insert highlights
                                                                                                               1
                                                                                                               base))
                                                                                               highlights))}}}}}
                                :sources {:default [:lsp :path :buffer]
                                          :providers {:ripgrep {:module :blink-ripgrep
                                                                :name :Ripgrep
                                                                :opts {:prefix_min_len 2
                                                                       :backend {:use :gitgrep-or-ripgrep}}}}}
                                :fuzzy {:implementation (if (is-nix)
                                                            :prefer_rust
                                                            :lua)}
                                :cmdline {:completion {:menu {:auto_show true}
                                                       :ghost_text {:enabled true}
                                                       :list {:selection {:preselect false
                                                                          :auto_insert true}}}}})}]
              [:blink.compat {:for_cat :blink :on_plugin [:blink.cmp]}]
              [:blink-ripgrep.nvim {:for_cat :blink :on_plugin [:blink.cmp]}]
              [:colorful-menu.nvim
               {:for_cat :blink
                :on_plugin [:blink.cmp]
                :after #(setup :colorful-menu {})}]))
