(import-macros {: tb : setup- : with-require} :macros)

(fn has-words-before []
  (let [col (. (vim.api.nvim_win_get_cursor 0) 2)]
    (if (= col 0)
        false
        (let [line (vim.api.nvim_get_current_line)]
          (= (string.match (string.sub line col col) "%s") nil)))))

[(tb :blink.cmp
     {:for_cat :general.blink
      :event :InsertEnter
      :after (setup- :blink.cmp
                     {:keymap {:preset :none
                               :<Tab> [(fn [cmp]
                                         (when (has-words-before)
                                           (or (cmp.show) (cmp.insert_next))))
                                       :fallback]
                               :<S-Tab> [:insert_prev]
                               "<M-;>" [(fn [cmp] (cmp.accept {:index 1}))]}
                      :appearance {:nerd_font_variant :normal}
                      :completion {:documentation {:auto_show true}
                                   :ghost_text {:enabled true
                                                :show_with_selection true
                                                :show_without_selection true
                                                :show_with_menu true
                                                :show_without_menu true}
                                   :keyword {:range :prefix}
                                   :list {:selection {:preselect false}
                                          :cycle {:from_top false}}
                                   :menu {:enabled true
                                          :auto_show false
                                          :auto_show_delay_ms 50
                                          :max_height 7
                                          :draw {:align_to :cursor
                                                 :columns [(tb :kind_icon)
                                                           (tb :label {:gap 1})]
                                                 :components {:label {:text (fn [ctx]
                                                                              (with-require {menu :colorful-menu}
                                                                                (menu.blink_components_text ctx)))
                                                                      :highlight (fn [ctx]
                                                                                   (with-require {menu :colorful-menu}
                                                                                     (menu.blink_components_highlight ctx)))}}}}}
                      :sources {:default [:lsp :path :buffer]}
                      :fuzzy {:implementation (with-require {cats :nixCatsUtils}
                                                (if cats.isNixCats
                                                    :prefer_rust
                                                    :lua))}
                      :cmdline {:completion {:menu {:auto_show false}}}})})
 (tb :blink.compat {:for_cat :general.blink :on_plugin [:blink.cmp]})
 (tb :colorful-menu.nvim
     {:for_cat :general.blink
      :on_plugin [:blink.cmp]
      :after (setup- :colorful-menu {})})]
