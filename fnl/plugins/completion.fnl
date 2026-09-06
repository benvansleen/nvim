(import-macros {: cfg : is-nix : require-and-call : setup} :macros)

(macro has-words-before []
  `(let [col# (. (vim.api.nvim_win_get_cursor 0) 2)]
     (if (= col# 0)
         false
         (let [line# (vim.api.nvim_get_current_line)]
           (= (string.match (string.sub line# col# col#) "%s") nil)))))

(cfg (nmap {[:NES :<Tab>] #(require-and-call :sidekick :nes_jump_or_apply)
            [:NES :<S-Tab>] #(require-and-call :sidekick
                                               :nes_jump_or_apply_backward)})
     (plugins [:blink.cmp
               {:for_cat :blink
                :event [:CmdlineEnter :InsertEnter]
                :after #(setup :blink.cmp
                               {:keymap {:preset :none
                                         :<Tab> [:snippet_forward
                                                 #(require-and-call :sidekick
                                                                    :nes_jump_or_apply)
                                                 (fn [cmp]
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
                                         :<CR> [:accept :fallback]
                                         "<M-:>" [#(require-and-call :copilot.suggestion
                                                                     :accept_word)]
                                         "<M-;>" [#(require-and-call :copilot.suggestion
                                                                     :accept)]
                                         "<D-:>" [#(require-and-call :copilot.suggestion
                                                                     :accept_word)]
                                         "<D-;>" [#(require-and-call :copilot.suggestion
                                                                     :accept)]
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
                                             :ghost_text {:enabled false
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
                                                                                                 (set base.group
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
                :after #(setup :colorful-menu {})}]
              [:copilot.lua
               {:for_cat :blink
                :on_require :copilot
                :on_plugin [:blink.cmp]
                :event :InsertEnter
                :after #(setup :copilot
                               {:panel {:enabled false}
                                :suggestion {:enabled true
                                             :auto_trigger true
                                             :hide_during_completion true
                                             :keymap {:accept false
                                                      :accept_word false
                                                      :accept_line false
                                                      :next false
                                                      :prev false
                                                      :dismiss false}}
                                ;; Sidekick owns next edit suggestions.
                                :nes {:enabled false}})}]
              [:sidekick.nvim
               {:for_cat :blink
                :on_plugin [:blink.cmp]
                :on_require :sidekick
                :event :CursorMoved
                :after #(setup :sidekick
                               {:nes {:enabled true}
                                :cli {:picker :telescope
                                      :mux {:enabled true :create :split}
                                      :win {:split {:width 0 :height 0}}}})}
               (nmap {["Toggle Sidekick" :<leader>aa] #(require-and-call :sidekick.cli
                                                                         :toggle)
                      ["Select Sidekick" :<leader>as] #(require-and-call :sidekick.cli
                                                                         :select)
                      ["Custom Sidekick prompt" :<leader>ai] #(vim.ui.input {:prompt "Sidekick: "}
                                                                            (fn [input]
                                                                              (when (and input
                                                                                         (not= input
                                                                                               ""))
                                                                                (require-and-call :sidekick.cli
                                                                                                  :send
                                                                                                  {:msg (.. "{line}: "
                                                                                                            input)}))))
                      ["Select Sidekick prompt" :<leader>ap] #(require-and-call :sidekick.cli
                                                                                :prompt)
                      ["Send file" :<leader>af] #(require-and-call :sidekick.cli
                                                                   :send
                                                                   {:msg "{file}"})
                      ["Send line" :<leader>al] #(require-and-call :sidekick.cli
                                                                   :send
                                                                   {:msg "{line}"})})
               (vmap {["Send selection" :<leader>av] #(require-and-call :sidekick.cli
                                                                        :send
                                                                        {:msg "{selection}"})})]))
