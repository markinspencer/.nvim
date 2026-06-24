return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        require("neo-tree").setup({
            filesystem = {
                hijack_netrw_behavior = "open_current",
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
            },
            window = {
                position = "right",
                width = 30,
                mappings = {
                    ["P"] = { "toggle_preview", config = { use_float = true } },
                    ["<cr>"] = function(state)
                        local node = state.tree:get_node()
                        if node.type == "file" then
                            vim.cmd("Neotree close")
                            vim.cmd("edit " .. vim.fn.fnameescape(node:get_id()))
                        else
                            require("neo-tree.sources.filesystem.commands").toggle_node(state)
                        end
                    end,
                },
            },
        })

        vim.keymap.set("n", "<C-b>", function()
            if vim.bo.filetype == "neo-tree" then
                vim.cmd("Neotree close")
            else
                vim.cmd("Neotree reveal toggle")
            end
        end, { desc = "Toggle file tree at current file" })
    end
}
