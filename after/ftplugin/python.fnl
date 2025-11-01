(import-macros {: config : with-require : with-preserve-position} :macros)

(fn toggle-fstring []
  (with-preserve-position [_ cursor]
    (let [node (with-require {ts :lib.treesitter}
                 (ts.nearest-parent-of-type :string))]
      (if (not node)
          (print "f-string-toggle: could not detect string at point")
          (let [(srow scol _ecol _erow) (with-require {ts-utils :nvim-treesitter.ts_utils}
                                          (ts-utils.get_vim_range [(node:range)]))]
            (vim.fn.setcursorcharpos [srow scol])
            (let [char (: (vim.api.nvim_get_current_line) :sub scol scol)]
              (if (= char :f)
                  (do
                    (vim.cmd "normal x")
                    (when (= srow (. cursor 1))
                      (tset cursor 2 (- (. cursor 2) 1))))
                  (do
                    (vim.cmd "normal if")
                    (when (= srow (. cursor 1))
                      (tset cursor 2 (+ (. cursor 2) 1)))))))))))

(config (nmap {:<leader>tf toggle-fstring}) (imap {:<M-f> toggle-fstring}))
