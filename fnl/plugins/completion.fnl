(import-macros {: tb : require-and-call} :macros)

(tb "blink.cmp"
    {:after (fn [_]
             (let [blink (require :blink.cmp)]
              (blink.setup {:keymap {:preset :enter
                                     "<Tab>" [:select_next :fallback]
                                     "<S-Tab>" [:select_prev :fallback]}
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
                                                :auto_show_delay_ms 50}}
                            :sources {:default [:lsp :path :buffer]}
                            :fuzzy {:implementation :prefer_rust_with_warning}})))})
