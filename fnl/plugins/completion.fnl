(import-macros {: tb : setup- : with-require} :macros)

[(tb :blink.cmp
     {:for_cat :general.blink
      :event :DeferredUIEnter
      :after (setup- :blink.cmp
                     {:keymap {:preset :enter
                               :<Tab> [:select_next :fallback]
                               :<S-Tab> [:select_prev :fallback]}
                      :appearance {:nerd_font_variant :normal}
                      :completion {:documentation {:auto_show true}
                                   :ghost_text {:enabled true
                                                :show_with_selection true
                                                :show_without_selection true
                                                :show_with_menu true
                                                :show_without_menu true}
                                   :keyword {:range :prefix}
                                   :menu {:enabled true
                                          :auto_show true
                                          :auto_show_delay_ms 50
                                          :max_height 3
                                          :draw {:columns [(tb :kind_icon)
                                                           (tb :label {:gap 1})]
                                                 :components {:label {:text (fn [ctx]
                                                                              (with-require [menu
                                                                                             :colorful-menu]
                                                                                (menu.blink_components_text ctx)))
                                                                      :highlight (fn [ctx]
                                                                                   (with-require [menu
                                                                                                  :colorful-menu]
                                                                                     (menu.blink_components_highlight ctx)))}}}}}
                      :sources {:default [:lsp :path :buffer]}
                      :fuzzy {:implementation :prefer_rust}
                      :cmdline {:keymap {:preset :inherit}
                                :completion {:menu {:auto_show true}}}})})
 (tb :blink.compat {:for_cat :general.blink :on_plugin [:blink.cmp]})
 (tb :colorful-menu.nvim
     {:for_cat :general.blink
      :on_plugin [:blink.cmp]
      :after (setup- :colorful-menu {})})]
