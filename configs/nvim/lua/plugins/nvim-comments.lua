return {
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup({
				comment = "gc",
				comment_string = "/*",
				marker_padding = true,
				hooks = {},
			})
		end,
	},
}
