(import-macros {: cfg
                : dot-repeatable
                : require-and-call
                : setup
                : unless-nix
                : with-require} :macros)

(dot-repeatable continue #(require-and-call :dap :continue))
(dot-repeatable step-over #(require-and-call :dap :step_over))
(dot-repeatable step-into #(require-and-call :dap :step_into))
(dot-repeatable step-out #(require-and-call :dap :step_out))
(dot-repeatable toggle-breakpoint #(require-and-call :dap :toggle_breakpoint))

(cfg (plugins [:nvim-dap
               {:for_cat {:cat :debug :default true}
                :on_require :dap
                :load (fn [name]
                        (vim.cmd.packadd name)
                        (vim.cmd.packadd :nvim-dap-view)
                        (vim.cmd.packadd :nvim-dap-virtual-text)
                        (vim.cmd.packadd :nvim-dap-python)
                        (vim.cmd.packadd :nvim-dap-repl-highlights))
                :after (fn [_]
                         (with-require {: dap}
                           (setup :dap-python :debugpy-adapter)
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
                                                     :position :right}}
                                 :windows {:terminal {:position :right}}})
                         (setup :nvim-dap-repl-highlights)
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
                                                     (let [value (if (> (length variable.value)
                                                                        30)
                                                                     (.. (variable.value:sub 1
                                                                                             15)
                                                                         "..."
                                                                         (variable.value:sub (- (length variable.value)
                                                                                                15)
                                                                                             (length variable.value)))
                                                                     variable.value)]
                                                       (if (= options.virt_text_pos
                                                              :inline)
                                                           (.. " = " value)
                                                           (.. variable.name
                                                               " = " value))))
                                 :virt_text_pos (if (= (vim.fn.has :nvim-0.10)
                                                       1)
                                                    :inline
                                                    :eol)}))}
               (nmap {["Debug: Start/Continue" :<leader>dc] continue
                      ["Debug: Restart" :<leader>dR] #(require-and-call :dap
                                                                        :restart)
                      ["Debug: Quit" :<leader>dq] #(require-and-call :dap
                                                                     :close)
                      ["Debug: Step Over" :<leader>dn] step-over
                      ["Debug: Step Into" :<leader>di] step-into
                      ["Debug: Step Out" :<leader>do] step-out
                      ["Debug: Clear Breakpoints" :<leader>dC] #(require-and-call :dap.breakpoints
                                                                                  :clear)
                      ["Debug: Toggle Breakpoint" :<leader>db] toggle-breakpoint
                      ["Debug: Set Conditional Breakpoint" :<leader>dB] #(with-require {: dap}
                                                                           (-> "Breakpoint condition: "
                                                                               vim.fn.input
                                                                               dap.set_breakpoint))
                      ["Debug: Set Watch" :<leader>dw] :<cmd>DapViewWatch<cr>
                      ["Debug: Open dap-view" :<leader>dt] #(require-and-call :dap-view
                                                                              :toggle)})]))
