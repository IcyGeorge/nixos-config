return {
	{
		"blink.cmp",
		enabled = nixCats('general') or false,
		event = "InsertEnter",
		on_require = "blink",
		after = function()
			require("blink.cmp").setup({
				keymap = {
					preset = "default",
				},

				appearance = {
					nerd_font_variant = "mono",
				},

				signature = {
					enabled = true,
				},

				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
					per_filetype = {
						lua = { inherit_defaults = true, 'lazydev' }
					},
					providers = {
						path = {
							score_offset = 50,
						},
						lsp = {
							score_offset = 40,
						},
						snippets = {
							score_offset = 40,
						},
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
					},
				},
			})
		end,
	},
}
