(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local config (autoload :nfnl.config))

(-> (config.default)
    (core.assoc :source-file-patterns
                [:init.fnl
                 :fnl/*.fnl
                 :fnl/**/*.fnl
                 :after/**/*.fnl
                 :ftdetect/**/*.fnl]))
