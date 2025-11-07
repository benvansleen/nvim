-- [nfnl] init.fnl
do
    local _1_
    do
        local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
        _1_ = cats_31_auto.isNixCats
    end
    if true == _1_ then
        vim.loader.enable()
    else
    end
end
do
    local p_7_auto = require("nixCatsUtils")
    p_7_auto.setup({ non_nix_value = true })
end
local function _4_()
    local _5_
    do
        local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
        _5_ = cats_31_auto.isNixCats
    end
    if false == _5_ then
        require("non_nix_download")
        return vim.cmd("PaqSync")
    else
        return nil
    end
end
return {
    { vim.keymap.set("n", " LP", _4_, { desc = "[L]oad non-nix [P]ackage manager", noremap = true }) },
    { require("config") },
}
