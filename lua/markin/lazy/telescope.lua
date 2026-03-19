return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "[p]roject [f]ind files" })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Find git files" })
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "[p]roject [w]ord [s]earch" })
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "[p]roject [W]ORD [s]earch" })
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "[p]roject [s]earch (grep)" })
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "[v]iew [h]elp tags" })
    end
}
