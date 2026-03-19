local local_plugins = {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>A", function()
				harpoon:list():prepend()
			end, { desc = "Harpoon: prepend file" })
			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "Harpoon: [a]dd file" })
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Harpoon: toggle menu" })

			-- Alt+N to set file at position N
			for i = 1, 6 do
				vim.keymap.set("n", "<M-" .. i .. ">", function()
					local list = harpoon:list()
					local item = list.config.create_list_item(list.config)
					list.items[i] = item
				end, { desc = "Harpoon: set slot [" .. i .. "]" })
			end

			-- Leader+N to navigate to position N
			for i = 1, 6 do
				vim.keymap.set("n", "<leader>" .. i, function()
					harpoon:list():select(i)
				end, { desc = "Harpoon: go to [" .. i .. "]" })
			end
		end,
	},
}

return local_plugins
