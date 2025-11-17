-- [nfnl] init.fnl
do
    local function _1_()
        require("non_nix_download")
        return vim.cmd.PaqSync()
    end
    vim.keymap.set("n", " LP", _1_, { desc = "[L]oad non-nix [P]ackage manager", noremap = true })
end
do
    local _2_
    do
        local cats_45_auto = require("nfnl.module").autoload("nixCatsUtils")
        _2_ = cats_45_auto.isNixCats
    end
    if true == _2_ then
        vim.loader.enable()
    else
    end
end
do
    local p_14_auto = require("nixCatsUtils")
    p_14_auto.setup({ non_nix_value = true })
end
return require("config")
