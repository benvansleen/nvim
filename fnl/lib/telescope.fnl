(import-macros {: autoload : define} :macros)
(autoload {: empty? : keys} :nfnl.core)
(define M :lib.telescope)

(fn M.pick-tab []
  (fn display-tab-name [buf tab-id]
    (.. tab-id ":\t" (vim.api.nvim_buf_get_name buf) "\t\t*"
        (vim.api.nvim_get_option_value :filetype {: buf}) "*"))

  (let [current-tab (vim.api.nvim_tabpage_get_number 0)
        tabs (collect [_ tab-id (ipairs (vim.api.nvim_list_tabpages))]
               (let [tab-num (vim.api.nvim_tabpage_get_number tab-id)]
                 (when (not= tab-num current-tab)
                   (values tab-id tab-num))))]
    (if (empty? tabs)
        (print "No open tabs")
        (vim.ui.select (keys tabs)
                       {:prompt "Select Tab"
                        :format_item #(-> $1
                                          vim.api.nvim_tabpage_get_win
                                          vim.api.nvim_win_get_buf
                                          (display-tab-name $1))}
                       #(when $1
                          (vim.cmd (.. "tabnext " (. tabs $1))))))))

M
