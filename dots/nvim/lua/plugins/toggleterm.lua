return {
	{
		"toggleterm.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("toggleterm").setup({
				direction = "horizontal",
				size = 15,
				open_mapping = [[<c-\>]],
				shade_terminals = false,
				persist_size = true,
				close_on_exit = true,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
			})
		end,
	},
}
