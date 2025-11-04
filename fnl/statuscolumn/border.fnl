;; from https://colordesigner.io/gradient-generator
(local colors ["#616161" "#555555" "#494949" "#3e3e3e" "#333333" "#282828"])

(fn highlights []
  (each [i fg (ipairs colors)]
    (vim.api.nvim_set_hl 0 (.. :Gradient_ i) {: fg})))

(fn border []
  (highlights)
  (if (< vim.v.relnum (- (length colors) 1))
      (.. "%#Gradient_" (+ vim.v.relnum 1) "#│")
      (.. "%#Gradient_" (length colors) "#│")))

{: border}
