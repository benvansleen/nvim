-- [nfnl] fnl/statuscolumn/statuscolumn.fnl
local statuscolumn = {}
statuscolumn.border = function(buf_ft)
    if
        vim.tbl_contains({
            "dashboard",
            "dap-repl",
            "dap-view",
            "dap-view-term",
            "NeogitStatus",
            "startuptime",
            "toggleterm",
            "TelescopePrompt",
        }, buf_ft)
    then
        return " "
    else
        return require("statuscolumn.border").border()
    end
end
statuscolumn.number = function(_)
    local linenum
    if vim.wo.relativenumber then
        linenum = (((vim.v.relnum == 0) and vim.v.lnum) or vim.v.relnum)
    else
        if vim.wo.number then
            linenum = vim.v.lnum
        else
            linenum = nil
        end
    end
    if linenum ~= nil then
        return string.format("%4d", linenum)
    else
        return ""
    end
end
statuscolumn["center-buffer"] = function(buf_ft)
    if vim.tbl_contains({ "TelescopePrompt" }, buf_ft) then
        return " "
    else
        return require("statuscolumn.center-buffer")["center-buffer"](buf_ft)
    end
end
statuscolumn.folds = function(buf_ft)
    if vim.tbl_contains({ "dap-repl", "dap-view", "dap-view-term", "TelescopePrompt", "startuptime" }, buf_ft) then
        return " "
    else
        return require("statuscolumn.folds").folds()
    end
end
statuscolumn.signs = function(buf_ft)
    if vim.tbl_contains({ "TelescopePrompt" }, buf_ft) then
        return " "
    else
        return "%s"
    end
end
statuscolumn.init = function()
    local buf_ft
    local function _8_(_241)
        return vim.api.nvim_get_option_value("filetype", { buf = _241 })
    end
    buf_ft = _8_(vim.api.nvim_get_current_buf())
    return (
        table.concat({
            statuscolumn["center-buffer"](buf_ft),
            statuscolumn.signs(buf_ft),
            statuscolumn.folds(buf_ft),
            "%l",
            statuscolumn.border(buf_ft),
            " ",
        }) or ""
    )
end
statuscolumn.activate = "%!v:lua.require('statuscolumn.setup').init()"
return statuscolumn
