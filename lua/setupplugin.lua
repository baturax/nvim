-- yazi
require("yazi").setup({
	open_for_directories = true,
})

require("ultimate-autopair").setup() -- pair

require('hex').setup()

require("blink.cmp").setup({
	completion = {
		trigger = { show_on_keyword = true },
		list = {
			selection = {
				preselect = true,
				auto_insert = true
			}
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500
		},
		ghost_text = { enabled = true }
	},

	fuzzy = { implementation = "lua" },

	keymap = {
		preset = "super-tab",
	},

	sources = {
		default = { "lsp", "snippets", "path", "buffer" },
	}
})


require("barbar").setup({
	animation = true,
	clickable = true,
	icons = {
		filetype = {
			enabled = false
		},
		enabled = false
	}
})

local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true
		}
	}
}

capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
