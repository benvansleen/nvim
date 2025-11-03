(import-macros {: tb
                : setup
                : require-and-call
                : require-and-call-
                : with-require
                : with-require-
                : dot-repeatable
                : unless-nix} :macros)

(dot-repeatable continue (require-and-call- :dap :continue))
(dot-repeatable step-over (require-and-call- :dap :step_over))
(dot-repeatable step-into (require-and-call- :dap :step_into))
(dot-repeatable step-out (require-and-call- :dap :step_out))
(dot-repeatable toggle-breakpoint (require-and-call- :dap :toggle_breakpoint))

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
                :load (fn [name]
                        (vim.cmd.packadd name)
                        (vim.cmd.packadd :nvim-dap-view)
                        (vim.cmd.packadd :nvim-dap-virtual-text)
                        (unless-nix (vim.cmd.packadd :mason-nvim-dap.nvim)))
                :after (fn [_]
                         (with-require {: dap}
                           (set dap.adapters.debugpy
                                {:type :executable :command :debugpy-adapter})
                           (set dap.adapters.gdb
                                {:type :executable
                                 :command :gdb
                                 :args [:--interpreter=dap
                                        :--eval-command
                                        "set print pretty on"]})
                           (set dap.adapters.rust-gdb
                                {:type :executable
                                 :command :rust-gdb
                                 :args [:--interpreter=dap
                                        :--eval-command
                                        "set print pretty on"]})
                           (set dap.configurations.python
                                [{:type :debugpy
                                  :request :Launch
                                  :name "Launch file"
                                  :program "${file}"
                                  :stopAtEntry true
                                  :justMyCode false
                                  :cwd "${workspaceFolder}"
                                  :pythonPath :.venv/bin/python}])
                           (set dap.configurations.c
                                [{:type :gdb
                                  :name :Launch
                                  :request :launch
                                  :program (fn []
                                             (vim.fn.input "Path to executable: "
                                                           (.. (vim.fn.getcwd)
                                                               "/")
                                                           :file))
                                  :cwd "${workspaceFolder}"
                                  :stopAtBeginningOfMainSubprogram false}])
                           (set dap.configurations.rust
                                [{:type :rust-gdb
                                  :name :Launch
                                  :request :launch
                                  :program (fn []
                                             (vim.fn.input "Path to executable: "
                                                           (.. (vim.fn.getcwd)
                                                               "/")
                                                           :file))
                                  :cwd "${workspaceFolder}"
                                  :stopAtBeginningOfMainSubprogram true}
                                 {:type :rust-gdb
                                  :name :Attach
                                  :request :attach
                                  :program (fn []
                                             (vim.fn.input "Path to executable: "
                                                           (.. (vim.fn.getcwd)
                                                               "/")
                                                           :file))
                                  :pid (fn []
                                         (require-and-call :dap.utils
                                                           :pick_process
                                                           {:filter (vim.fn.input "Executable name (filter): ")}))
                                  :cwd "${workspaceFolder}"}])
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
                                {:auto_toggle false
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
