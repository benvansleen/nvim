(import-macros {: tb
                : setup
                : require-and-call-
                : with-require
                : with-require-
                : dot-repeatable-} :macros)

(local continue (dot-repeatable- :dap :continue))
(local step-over (dot-repeatable- :dap :step_over))
(local step-into (dot-repeatable- :dap :step_into))
(local step-out (dot-repeatable- :dap :step_out))
(local toggle-breakpoint (dot-repeatable- :dap :toggle_breakpoint))

[(tb :nvim-dap {:for_cat {:cat :debug :default false}
                :on_require :dap
                :keys [(tb :<leader>dc continue {:desc "Debug: Start/Continue"})
                       (tb :<leader>dR (require-and-call- :dap :restart)
                           {:desc "Debug: Restart"})
                       (tb :<leader>dq (require-and-call- :dap :close)
                           {:desc "Debug: Quit"})
                       (tb :<leader>di step-into {:desc "Debug: Step Into"})
                       (tb :<leader>dn step-over {:desc "Debug: Step Over"})
                       (tb :<leader>do step-out {:desc "Debug: Step Out"})
                       (tb :<leader>dC
                           (require-and-call- :dap.breakpoints :clear)
                           {:desc "Debug: Clear Breakpoints"})
                       (tb :<leader>db toggle-breakpoint
                           {:desc "Debug: Toggle Breakpoint"})
                       (tb :<leader>dB
                           (with-require- {: dap}
                             (-> "Breakpoint condition: "
                                 vim.fn.input
                                 dap.set_breakpoint))
                           {:desc "Debug: Set Conditional Breakpoint"})
                       (tb :<leader>dw :<cmd>DapViewWatch<cr>
                           {:desc "Debug: Set Watch"})
                       (tb :<leader>dt (require-and-call- :dap-view :toggle)
                           {:desc "Debug: See last session result"})]
                :load (if (with-require {: nixCatsUtils} nixCatsUtils.isNixCats)
                          (fn [name]
                            (vim.cmd.packadd name)
                            (vim.cmd.packadd :nvim-dap-view)
                            (vim.cmd.packadd :nvim-dap-virtual-text))
                          (fn [name]
                            (vim.cmd.packadd name)
                            (vim.cmd.packadd :nvim-dap-view)
                            (vim.cmd.packadd :nvim-dap-virtual-text)
                            (vim.cmd.packadd :mason-nvim-dap.nvim)))
                :after (fn [_]
                         (with-require {: dap}
                           (set dap.adapters.debugpy
                                {:type :executable :command :debugpy-adapter})
                           (set dap.configurations.python
                                [{:type :debugpy
                                  :request :launch
                                  :name "Launch file"
                                  :program "${file}"
                                  :stopAtEntry true
                                  :justMyCode false
                                  :cwd "${workspaceFolder}"
                                  :pythonPath :.venv/bin/python}])
                           (vim.api.nvim_set_hl 0 :BreakpointLineHl
                                                {:underdotted true})
                           (vim.api.nvim_set_hl 0 :DapLineAtPointLineHl
                                                {:underline true})
                           (vim.fn.sign_define [{:name :DapBreakpoint
                                                 :text ""
                                                 :texthl :Red
                                                 :linehl :BreakpointLineHl}
                                                {:name :DapBreakpointCondition
                                                 :text ""
                                                 :texthl :Yellow
                                                 :linehl :DapBreakpointLineHl}
                                                {:name :DapStopped
                                                 :text "→"
                                                 :linehl :DapLineAtPointLineHl}]))
                         (setup :dap-view
                                {:auto_toggle true
                                 :winbar {:sections [:repl
                                                     :watches
                                                     :scopes
                                                     :exceptions
                                                     :breakpoints
                                                     :threads]
                                          :default_section :repl
                                          :controls {:enabled true
                                                     :position :right}}})
                         (setup :nvim-dap-virtual-text
                                {:enabled true
                                 :enabled_commands true
                                 :highlight_changed_variables true
                                 :highlight_new_as_changed false
                                 :show_stop_reason true
                                 :commented false
                                 :only_first_definition true
                                 :all_references false
                                 :clear_on_continue false
                                 :display_callback (fn [variable
                                                        _buf
                                                        _stackframe
                                                        _node
                                                        options]
                                                     (if (= options.virt_text_pos
                                                            :inline)
                                                         (.. " = "
                                                             variable.value)
                                                         (.. variable.name
                                                             " = "
                                                             variable.value)))
                                 :virt_text_pos (if (= (vim.fn.has :nvim-0.10)
                                                       1)
                                                    :inline
                                                    :eol)}))})]
