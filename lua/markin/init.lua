require("markin.set")
require("markin.remap")
require("markin.lazy_init")

local augroup = vim.api.nvim_create_augroup
local MarkinGroup = augroup('Markin', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = MarkinGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('BufEnter', {
    group = MarkinGroup,
    callback = function()
        if vim.bo.filetype == "zig" then
            pcall(SetTheme, "tokyonight-night")
        else
            pcall(SetTheme, "vespernoir")
        end
    end
})


autocmd('LspAttach', {
    group = MarkinGroup,
    callback = function(e)
        local opts = function(desc) return { buffer = e.buf, desc = desc } end
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts("[g]o to [d]efinition"))
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts("LSP: hover info"))
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts("[v]iew [w]orkspace [s]ymbols"))
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts("[v]iew [d]iagnostic float"))
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts("[v]iew [c]ode [a]ction"))
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts("[v]iew [r]efe[r]ences"))
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts("[v]iew [r]e[n]ame"))
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts("Signature [h]elp"))
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts("Next [d]iagnostic"))
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts("Prev [d]iagnostic"))
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
