return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15 -- Высота для горизонтального терминала
				elseif term.direction == "vertical" then
					return 50 -- Ширина для вертикального
				else
					return nil -- Для float можно не задавать
				end
      end,
			open_mapping = [[<C-r>]], -- Открытие по Ctrl+T
			direction = "float", -- Попробуй "horizontal" или "vertical" для теста
			shade_terminals = false,
    })
	end,
}
