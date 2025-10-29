(import-macros {: tb} :macros)

(let [lze (require :lze)
      cats (require :nixCatsUtils)]
  (lze.load [(tb :nvim-dap
                 {:for_cat {:cat :debug :default false}
                  :keys [(tb :<F5> {:desc "Debug: Start/Continue"})
                         (tb :<F1> {:desc "Debug: Step Into"})
                         (tb :<F2> {:desc "Debug: Step Over"})
                         (tb :<F3> {:desc "Debug: Step Out"})
                         (tb :<leader>b {:desc "Debug: Toggle Breakpoint"})
                         (tb :<leader>B {:desc "Debug: Set Breakpoint"})
                         (tb :<F7> {:desc "Debug: See last session result"})]
                  :load (if cats.isNixCats
                            (fn [name]
                              (vim.cmd.packadd name)
                              (vim.cmd.packadd :nvim-dap-ui)
                              (vim.cmd.packadd :nvim-dap-virtual-text))
                            (fn [name]
                              (vim.cmd.packadd name)
                              (vim.cmd.packadd :nvim-dap-ui)
                              (vim.cmd.packadd :nvim-dap-virtual-text)
                              (vim.cmd.packadd :mason-nvim-dap.nvim)))
                  :after (fn [_]
                           (let [dap (require :dap)
                                 dapui (require :dapui)]
                             (vim.keymap.set :n :<F5> dap.continue
                                             {:desc "Debug: Start/Continue"})
                             (vim.keymap.set :n :<F1> dap.step_into
                                             {:desc "Debug: Step Into"})
                             (vim.keymap.set :n :<F2> dap.step_over
                                             {:desc "Debug: Step Over"})
                             (vim.keymap.set :n :<F3> dap.step_out
                                             {:desc "Debug: Step out"})
                             (vim.keymap.set :n :<F7> dapui.toggle
                                             {:desc "Debug: See last session result"})
                             (vim.keymap.set :n :<leader>b
                                             dap.toggle_breakpoint
                                             {:desc "Debug: Toggle Breakpoint"})
                             (vim.keymap.set :n :<leader>B
                                             (fn []
                                               (dap.set_breakpoint (vim.fn.input "Breakpoint condition: ")))
                                             {:desc "Debug: Set Breakpoint"})
                             (set dap.listeners.after.event_initialized.dapui_config
                                  dapui.open)
                             (set dap.listeners.before.event_terminated.dapui_config
                                  dapui.close)
                             (set dap.listeners.before.event_exited.dapui_config
                                  dapui.close)
                             (dapui.setup {:icons {:expanded "▾"
                                                   :collapsed "▸"
                                                   :current_frame "*"}
                                           :controls {:icons {:pause "⏸"
                                                              :play "▶"
                                                              :step_into "⏎"
                                                              :step_over "⏭"
                                                              :step_out "⏮"
                                                              :step_back :b
                                                              :run_last "▶▶"
                                                              :terminate "⏹"
                                                              :disconnect "⏏"}}}))
                           (let [vt (require :nvim-dap-virtual-text)]
                             (vt.setup {:enabled true
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
                                                           :eol)})))})]))
