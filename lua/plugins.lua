local gh = "https://github.com/"

vim.pack.add({
	{ src = gh .. "mikavilpas/yazi.nvim" },          -- yazi
	{ src = gh .. "altermo/ultimate-autopair.nvim" }, -- autopair
	{ src = gh .. "projekt0n/github-nvim-theme" },   -- theme
	{ src = gh .. "saghen/blink.cmp" },
	{ src = gh .. "neovim/nvim-lspconfig" },
	{ src = gh .. "romgrk/barbar.nvim" },
	{ src = gh .. "b0o/schemastore.nvim" },

	-- dependencies
	{ src = gh .. "nvim-lua/plenary.nvim" }
})
