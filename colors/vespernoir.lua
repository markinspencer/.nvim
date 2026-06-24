-- Vesper Noir: the Pastel Noir palette with Vesper's reds.
-- Loads pastelnoir, then swaps rose #E8849A -> coral #FF8080 and salmon #F0A695 -> #F5A191.

-- dofile instead of :colorscheme — the nested colorscheme command no-ops
-- while lazy.nvim is mid-startup, which left the base palette unloaded
local this_file = debug.getinfo(1, "S").source:sub(2)
dofile(vim.fn.fnamemodify(this_file, ":h") .. "/pastelnoir.lua")
vim.g.colors_name = "vespernoir"

local coral = "#FF8080"   -- Vesper bright red
local salmon = "#F5A191"  -- Vesper red

local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- rose -> coral
hl("ErrorMsg", { fg = coral })
hl("Error", { fg = coral })
hl("Exception", { fg = coral })
hl("Debug", { fg = coral })
hl("DiagnosticError", { fg = coral })
hl("DiagnosticUnderlineError", { undercurl = true, sp = coral })
hl("DiffDelete", { fg = coral, bg = "NONE" })
hl("Removed", { fg = coral })
hl("GitSignsDelete", { fg = coral })
hl("SpellBad", { undercurl = true, sp = coral })

-- salmon -> vesper salmon
hl("IncSearch", { fg = "#111111", bg = salmon })
hl("CurSearch", { fg = "#111111", bg = salmon })
hl("PreProc", { fg = salmon })
hl("Include", { fg = salmon })
hl("Define", { fg = salmon })
hl("Macro", { fg = salmon })
hl("Special", { fg = salmon })
hl("SpecialChar", { fg = salmon })
hl("@variable.builtin", { fg = salmon })
hl("@string.escape", { fg = salmon })

-- ANSI reds match the Windows Terminal "Vesper Noir" scheme
vim.g.terminal_color_1 = salmon
vim.g.terminal_color_9 = coral
