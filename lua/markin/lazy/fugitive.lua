return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[g]it [s]tatus" })

        local Markin_Fugitive = vim.api.nvim_create_augroup("Markin_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = Markin_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = {buffer = bufnr, remap = false}
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, vim.tbl_extend("force", opts, { desc = "Git [p]ush" }))

                -- rebase always
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({'pull',  '--rebase'})
                end, vim.tbl_extend("force", opts, { desc = "Git [P]ull --rebase" }))

                -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                -- needed if i did not set the branch up correctly
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", vim.tbl_extend("force", opts, { desc = "Git push -u origin [t]rack" }));
            end,
        })


        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "[g]it: pick [u]pstream (left)" })
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "[g]it: pick [h]ead (right)" })
    end
}
