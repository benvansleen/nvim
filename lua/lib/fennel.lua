-- [nfnl] fnl/lib/fennel.fnl
local function get_associated_file()
    local case_1_ = vim.fn.expand("%:e")
    if case_1_ == "lua" then
        return string.gsub(string.gsub(vim.fn.expand("%:p"), "%.lua", "%.fnl"), "/lua/", "/fnl/")
    elseif case_1_ == "fnl" then
        return string.gsub(string.gsub(vim.fn.expand("%:p"), "%.fnl", "%.lua"), "/fnl/", "/lua/")
    else
        return nil
    end
end
--[[ (get-associated-file) ]]
local function cmd_on_associated_file(cmd)
    return vim.cmd((cmd .. " " .. get_associated_file()))
end
--[[ (cmd-on-associated-file "edit") ]]
return { ["cmd-on-associated-file"] = cmd_on_associated_file }
