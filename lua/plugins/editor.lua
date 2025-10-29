-- [nfnl] fnl/plugins/editor.fnl
local function _1_(_)
	local comment_ = require("Comment")
	return comment_.setup()
end
local function _2_(_)
	local fidget = require("fidget")
	return fidget.setup()
end
local function _3_(_)
	local ibl = require("ibl")
	return ibl.setup({ exclude = { filetypes = { "fennel" } } })
end
local function _4_(_)
	local leap = require("leap")
	leap.opts.safe_labels = ""
	leap.opts.preview = false
	return vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
end
local function _5_(_)
	local nvim_surround = require("nvim-surround")
	return nvim_surround.setup()
end
local function _6_(_)
	vim.g.startuptime_event_width = 0
	vim.g.startuptime_tries = 10
	vim.g.startuptime_exe_path = nixCats.packageBinPath
	return nil
end
local function _7_(_)
	local which_key = require("which-key")
	which_key.setup({})
	return which_key.add({
		{ "<leader><leader>", group = "buffer commands" },
		{ "<leader><leader>_", hidden = true },
		{ "<leader>c", group = "[c]ode" },
		{ "<leader>c_", hidden = true },
		{ "<leader>d", group = "[d]ocument" },
		{ "<leader>d_", hidden = true },
		{ "<leader>f", group = "[f]ind" },
		{ "<leader>f_", hidden = true },
		{ "<leader>g", group = "[g]it" },
		{ "<leader>g_", hidden = true },
		{ "<leader>r", group = "[r]ename" },
		{ "<leader>r_", hidden = true },
		{ "<leader>t", group = "[t]oggle" },
		{ "<leader>t_", hidden = true },
		{ "<leader>w", group = "[w]orkspace" },
		{ "<leader>w_", hidden = true },
	})
end
return {
	{ "comment.nvim", after = _1_, event = "DeferredUIEnter", for_cat = "general.extra" },
	{ "fidget.nvim", after = _2_, event = "DeferredUIEnter", for_cat = "general.extra" },
	{ "indent-blankline.nvim", after = _3_, event = "DeferredUIEnter", for_cat = "general.extra" },
	{
		"leap.nvim",
		after = _4_,
		for_cat = "general.always",
		keys = { { "s", "<Plug>(leap)", desc = "Leap!", mode = { "n", "x", "o" } } },
	},
	{ "nvim-surround", after = _5_, event = "DeferredUIEnter", for_cat = "general.always" },
	{
		"undotree",
		cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotrPersistUndo" },
		for_cat = "general.extra",
		keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree", mode = { "n" } } },
	},
	{ "vim-startuptime", before = _6_, cmd = { "StartupTime" }, for_cat = "general.extra" },
	{ "which-key.nvim", after = _7_, event = "DeferredUIEnter", for_cat = "general.extra" },
}
