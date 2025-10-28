-- [nfnl] fnl/config.fnl
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {})
local screen_width = vim.api.nvim_win_get_width(0)
local statuscolumn = "  %l%r%s%C"
local statuscolumn_wide = (string.rep(" ", ((screen_width - 100) / 3)) .. statuscolumn)
do local _ = {require("plugins")} end
vim.opt["fillchars"] = {eob = " "}
vim.opt["laststatus"] = 0
vim.opt["statuscolumn"] = statuscolumn
vim.opt["statusline"] = "%{repeat('\226\148\128',winwidth('.'))}"
vim.opt["number"] = false
vim.opt["relativenumber"] = false
vim.opt["ruler"] = false
vim.opt["showcmd"] = false
vim.opt["showmode"] = false
do local _ = {nil, nil, nil, nil, nil, nil, nil, nil, nil} end
vim.g["my_center_buffer"] = false
do local _ = {nil} end
local function _1_()
  local cur = vim.wo.nu
  vim.wo.number = not cur
  vim.wo.relativenumber = not cur
  return nil
end
local function _2_()
  vim.g.my_center_buffer = not vim.g.my_center_buffer
  return nil
end
local function _3_()
  return print(vim.api.nvim_buf_get_name(0))
end
local function _4_()
  return vim.api.nvim_buf_delete(0, {})
end
do local _ = {vim.keymap.set("n", "<leader>tn", _1_), vim.keymap.set("n", "<leader>tc", _2_), vim.keymap.set("n", "<leader>wtf", _3_), vim.keymap.set("n", "<leader>q", _4_)} end
do local _ = {vim.keymap.set("i", "jj", "<ESC>")} end
local function _5_()
  local winwidth = vim.api.nvim_win_get_width(0)
  if (vim.g.my_center_buffer and (winwidth > (screen_width / 3))) then
    vim.wo.statuscolumn = statuscolumn_wide
    return nil
  else
    vim.wo.statuscolumn = statuscolumn
    return nil
  end
end
local function _7_()
  if (vim.wo.nu and ("i" ~= vim.api.nvim_get_mode().mode)) then
    vim.wo.relativenumber = true
    return nil
  else
    return nil
  end
end
local function _9_()
  if vim.wo.nu then
    vim.wo.relativenumber = false
    return nil
  else
    return nil
  end
end
return {vim.api.nvim_create_autocmd({"BufWinEnter"}, {desc = "return cursor to where it was last time file was closed", pattern = "*", command = "silent! normal! g`\"zv"}), vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "BufWinLeave", "WinEnter", "WinLeave", "WinResized", "VimResized"}, {callback = _5_}), vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter"}, {pattern = "*", group = numbertoggle, callback = _7_, nested = false, once = false}), vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave"}, {pattern = "*", group = numbertoggle, callback = _9_, nested = false, once = false})}
