(import-macros {: cfg : is-nix : setup} :macros)

(if (is-nix)
    (cfg (plugins [:blink.pairs
                   {:for_cat :general.blink
                    :event :DeferredUIEnter
                    :after #(setup :blink.pairs
                                   {:mappings {:enabled true
                                               :cmdline true
                                               :disabled_filetypes []}
                                    :highlights {:enabled true
                                                 :cmdline true
                                                 :groups [:NonText]
                                                 :matchparen {:enabled true
                                                              :cmdline false
                                                              :include_surrounding true}}})}]))
    (cfg (plugins [:nvim-autopairs
                   {:for_cat :general.always
                    :event :InsertEnter
                    :after #(setup :nvim-autopairs
                                   {:check_ts true
                                    :disable_filetype [:TelescopePrompt]
                                    :disable_in_macro true
                                    :enable_check_bracket_line true})}])))
