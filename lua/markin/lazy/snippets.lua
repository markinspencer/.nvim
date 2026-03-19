
return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        -- build = "make install_jsregexp", -- disabled on Windows (requires Lua headers)

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")
            ls.filetype_extend("javascript", { "jsdoc" })

            vim.keymap.set({"i"}, "<M-s>", function() ls.expand() end, {silent = true, desc = "Snippet: expand"})

            vim.keymap.set({"i", "s"}, "<M-j>", function() ls.jump(1) end, {silent = true, desc = "Snippet: jump forward"})
            vim.keymap.set({"i", "s"}, "<M-k>", function() ls.jump(-1) end, {silent = true, desc = "Snippet: jump backward"})

            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {silent = true})
        end,
    }
}

