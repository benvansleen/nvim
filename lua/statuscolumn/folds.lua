-- [nfnl] fnl/statuscolumn/folds.fnl
_G.click_handler = function()
    return vim.cmd("normal! za")
end
local function folds()
    local foldlevel = vim.fn.foldlevel(vim.v.lnum)
    local foldlevel_before = vim.fn.foldlevel(((((vim.v.lnum - 1) >= 1) and (vim.v.lnum - 1)) or (vim.v.lnum - 1)))
    local foldlevel_after =
        vim.fn.foldlevel(((((vim.v.lnum + 1) <= vim.fn.line("$")) and (vim.v.lnum + 1)) or vim.fn.line("$")))
    local foldclosed = vim.fn.foldclosed(vim.v.lnum)
    local _1_
    if (vim.v.virtnum ~= 0) or (foldlevel == 0) then
        _1_ = " "
    else
        if (foldclosed ~= -1) and (foldclosed == vim.v.lnum) then
            _1_ = "\226\150\182"
        else
            if foldlevel > foldlevel_before then
                _1_ = "\226\150\189"
            else
                if foldlevel > foldlevel_after then
                    _1_ = "\226\149\176"
                else
                    _1_ = "\226\148\130"
                end
            end
        end
    end
    return ("%@v:lua.click_handler@" .. _1_)
end
return { folds = folds }
