(import-macros {: cfg : require-and-call : with-require} :macros)

(cfg (plugins [:opencode.nvim
               {:for_cat :general.extra :on_require :opencode}
               (nmap {["[A]sk opencode" :<leader>oa] #(with-require {: opencode}
                                                        (opencode.ask "@this: "
                                                                      {:submit true}))
                      ["[S]elect opencode action" :<leader>os] #(require-and-call :opencode
                                                                                  :select)
                      ["[B]uild agent" :<leader>ob] #(with-require {: opencode}
                                                       (opencode.prompt "@build @this"))
                      ["[P]lan agent" :<leader>op] #(with-require {: opencode}
                                                      (opencode.prompt "@plan @this"))
                      ["[T]oggle opencode" :<leader>ot] #(require-and-call :opencode
                                                                           :toggle)
                      ["Cycle opencode agent" :<leader>o<tab>] #(with-require {: opencode}
                                                                  (opencode.command :agent.cycle))
                      ["Scroll opencode up" :<leader>ok] #(with-require {: opencode}
                                                            (opencode.command :session.page.up))
                      ["Scroll opencode down" :<leader>oj] #(with-require {: opencode}
                                                              (opencode.command :session.page.down))})]))
