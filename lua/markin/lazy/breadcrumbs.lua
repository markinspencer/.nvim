return {
    "SmiteshP/nvim-navic",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local navic = require("nvim-navic")
        navic.setup({
            lsp = { auto_attach = true },
            highlight = true,
            separator = " > ",
        })

        local function get_relative_path()
            local filepath = vim.fn.expand("%:p")
            if filepath == "" then return "" end
            local rel = vim.fn.fnamemodify(filepath, ":.")
            if rel == filepath then
                rel = vim.fn.fnamemodify(filepath, ":t")
            end
            local parts = {}
            for part in rel:gmatch("[^/\\]+") do
                table.insert(parts, part)
            end
            local ok, devicons = pcall(require, "nvim-web-devicons")
            if ok then
                local icon = devicons.get_icon(parts[#parts])
                if icon then
                    parts[#parts] = icon .. " " .. parts[#parts]
                end
            end
            return table.concat(parts, " > ")
        end

        local function update_winbar()
            if vim.bo.buftype ~= "" then return end
            local path = get_relative_path()
            if path == "" then return end
            local location = ""
            if navic.is_available() then
                location = navic.get_location()
            end
            if location ~= "" then
                vim.wo.winbar = path .. " > " .. location
            else
                vim.wo.winbar = path
            end
        end

        vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved", "CursorMovedI" }, {
            callback = update_winbar,
        })
    end
}
