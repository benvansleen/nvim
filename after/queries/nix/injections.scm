;; from https://discourse.nixos.org/t/nix-syntax-highlighting-and-highlighting-inside-strings/46823/8
((comment) @injection.language
  .
  (_ (string_fragment) @injection.content)
  (#gsub! @injection.language "[/*#%s]" "")
  (#set! injection.combined))
