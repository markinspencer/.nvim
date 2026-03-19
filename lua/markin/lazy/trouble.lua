return {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({ })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end, { desc = "[t]rouble [t]oggle" })

            vim.keymap.set("n", "[t", function()
                require("trouble").next({skip_groups = true, jump = true});
            end, { desc = "Next [t]rouble item" })

            vim.keymap.set("n", "]t", function()
                require("trouble").previous({skip_groups = true, jump = true});
            end, { desc = "Prev [t]rouble item" })

        end
}
