-- [nfnl] fnl/plugins/completion.fnl
local function _1_(_)
	local blink = require("blink.cmp")
	local function _2_(ctx)
		local menu = require("colorful-menu")
		return menu.blink_components_text(ctx)
	end
	local function _3_(ctx)
		local menu = require("colorful-menu")
		return menu.blink_components_highlight(ctx)
	end
	return blink.setup({
		keymap = {
			preset = "enter",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
		},
		appearance = { nerd_font_variant = "normal" },
		completion = {
			documentation = { auto_show = true },
			ghost_text = {
				enabled = true,
				show_with_selection = true,
				show_without_selection = true,
				show_with_menu = true,
				show_without_menu = true,
			},
			keyword = { range = "prefix" },
			menu = {
				enabled = true,
				auto_show = true,
				auto_show_delay_ms = 50,
				max_height = 3,
				draw = {
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = { label = { text = _2_, highlight = _3_ } },
				},
			},
		},
		sources = { default = { "lsp", "path", "buffer" } },
		fuzzy = { implementation = "prefer_rust_with_warning" },
	})
end
local function _4_(_)
	local menu = require("colorful-menu")
	return menu.setup({})
end
return {
	{ "blink.cmp", after = _1_, event = "DeferredUIEnter", for_cat = "general.blink" },
	{ "blink.compat", for_cat = "general.blink", on_plugin = { "blink.cmp" } },
	{ "colorful-menu.nvim", after = _4_, for_cat = "general.blink", on_plugin = { "blink.cmp" } },
}
