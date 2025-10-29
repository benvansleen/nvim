-- [nfnl] fnl/plugins/telescope.fnl
local function _1_(_)
	local telescope = require("telescope")
	local _2_
	do
		local fb = telescope.extensions.file_browser.actions
		_2_ = { mappings = { i = { ["<left>"] = fb.backspace } } }
	end
	telescope.setup({
		defaults = {
			border = true,
			layout_config = {
				horizontal = {
					prompt_position = "top",
					width = { padding = 0 },
					height = { padding = 0 },
					preview_width = 0.5,
				},
				vertical = {
					prompt_position = "top",
					width = { padding = 0.02 },
					height = { padding = 0 },
					preview_height = 0.6,
				},
			},
			layout_strategy = "vertical",
			path_display = { "filename_first" },
			prompt_prefix = "\239\129\148\239\129\148 ",
			selection_caret = "\239\129\148 ",
			sorting_strategy = "ascending",
			prompt_title = false,
			results_title = false,
		},
		extensions = {
			["ui-select"] = { require("telescope.themes").get_cursor() },
			cmdline = { picker = require("telescope.themes").get_ivy({ layout_config = { height = 0.3 } }) },
			file_browser = _2_,
		},
	})
	telescope.load_extension("ui-select")
	telescope.load_extension("fzf")
	telescope.load_extension("file_browser")
	return telescope.load_extension("cmdline")
end
local function _3_()
	return require("telescope.builtin").find_files()
end
local function _4_()
	return require("telescope.builtin").oldfiles()
end
local function _5_()
	return require("telescope.builtin").buffers()
end
local function _6_()
	return require("telescope.builtin").current_buffer_fuzzy_find()
end
local function _7_()
	return require("telescope.builtin").diagnostics()
end
local function _8_()
	return require("telescope.builtin").resume()
end
local function _9_()
	return require("telescope.builtin").keymaps()
end
local function _10_()
	return require("telescope.builtin").help_tags()
end
local function _11_()
	return require("telescope.builtin").builtin()
end
local function _12_()
	return require("telescope.builtin").lsp_references()
end
local function _13_(name)
	vim.cmd.packadd(name)
	vim.cmd.packadd("telescope-fzf-native.nvim")
	vim.cmd.packadd("telescope-ui-select.nvim")
	vim.cmd.packadd("telescope-file-browser.nvim")
	return vim.cmd.packadd("telescope-cmdline")
end
return {
	"telescope.nvim",
	after = _1_,
	cmd = { "Telescope", "LiveGrepGitRoot" },
	for_cat = "general.telescope",
	keys = {
		{ ";", "<cmd>Telescope cmdline<CR>", desc = "Execute extended command", mode = { "n" } },
		{
			"<leader>ff",
			"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
			desc = "[F]ind [F]ile",
			mode = { "n" },
		},
		{ "<leader>pf", _3_, desc = "Find [P]roject [F]ile", mode = { "n" } },
		{ "<leader>fh", _4_, desc = "[F]ind in file [H]istory", mode = { "n" } },
		{ "<leader>fb", _5_, desc = "[F]ind [B]uffer", mode = { "n" } },
		{ "<leader>fl", _6_, desc = "[F]ind [L]ine", mode = { "n" } },
		{ "<leader>fd", _7_, desc = "[F]ind [D]iagnostic", mode = { "n" } },
		{ "<leader>fr", _8_, desc = "[F]ind [R]resume", mode = { "n" } },
		{ "<leader>fk", _9_, desc = "[F]ind [K]eymap", mode = { "n" } },
		{ "<leader>fH", _10_, desc = "[F]ind [H]elp", mode = { "n" } },
		{ "<leader>fm", "<cmd>Telescope notify<CR>", desc = "[F]ind [M]essage", mode = { "n" } },
		{ "<leader>ft", _11_, desc = "[F]ind [T]elescope", mode = { "n" } },
		{ "<leader>gr", _12_, desc = "[G]o to [R]eferences", mode = { "n" } },
	},
	load = _13_,
	on_require = { "telescope" },
}
