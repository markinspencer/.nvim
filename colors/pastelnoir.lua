-- Pastel Noir: muted pastels on near-black, derived from a benchmark-table screenshot.
-- Heat-map colors: salmon (low) -> peach (mid) -> sage (high); lavender costs, orchid durations.

local p = {
    bg = "#111111",
    bg_alt = "#1A1A1A",
    bg_sel = "#33313A",
    fg = "#EDEDED",
    fg_dim = "#A8A8A8",
    gray = "#5C5C5C",
    comment = "#6B6B6B",
    rose = "#E8849A",
    rose_br = "#F0A4B5",
    salmon = "#F0A695",
    peach = "#F2C9A4",
    peach_br = "#F8DDC3",
    sage = "#9FD7BC",
    sage_br = "#BCE5D1",
    teal = "#9FD0D7",
    lavender = "#ABA6DF",
    lavender_br = "#C7C3EC",
    orchid = "#E9A1D2",
    orchid_br = "#F3BFE2",
    white = "#FFFFFF",
}

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "pastelnoir"

local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- UI
hl("Normal", { fg = p.fg, bg = p.bg })
hl("NormalFloat", { fg = p.fg, bg = p.bg_alt })
hl("FloatBorder", { fg = p.gray, bg = p.bg_alt })
hl("Cursor", { fg = p.bg, bg = p.white })
hl("CursorLine", { bg = p.bg_alt })
hl("CursorColumn", { bg = p.bg_alt })
hl("ColorColumn", { bg = p.bg_alt })
hl("LineNr", { fg = p.gray })
hl("CursorLineNr", { fg = p.fg, bold = true })
hl("SignColumn", { bg = "NONE" })
hl("Visual", { bg = p.bg_sel })
hl("Search", { fg = p.bg, bg = p.peach })
hl("IncSearch", { fg = p.bg, bg = p.salmon })
hl("CurSearch", { fg = p.bg, bg = p.salmon })
hl("MatchParen", { fg = p.orchid_br, bold = true })
hl("StatusLine", { fg = p.fg, bg = p.bg_alt })
hl("StatusLineNC", { fg = p.fg_dim, bg = p.bg_alt })
hl("WinSeparator", { fg = p.gray })
hl("VertSplit", { fg = p.gray })
hl("Pmenu", { fg = p.fg, bg = p.bg_alt })
hl("PmenuSel", { fg = p.white, bg = p.bg_sel })
hl("PmenuSbar", { bg = p.bg_alt })
hl("PmenuThumb", { bg = p.gray })
hl("TabLine", { fg = p.fg_dim, bg = p.bg_alt })
hl("TabLineFill", { bg = p.bg })
hl("TabLineSel", { fg = p.fg, bg = p.bg })
hl("Folded", { fg = p.fg_dim, bg = p.bg_alt })
hl("FoldColumn", { fg = p.gray })
hl("NonText", { fg = p.gray })
hl("Whitespace", { fg = p.bg_sel })
hl("EndOfBuffer", { fg = p.bg })
hl("Directory", { fg = p.lavender })
hl("Title", { fg = p.lavender_br, bold = true })
hl("ErrorMsg", { fg = p.rose })
hl("WarningMsg", { fg = p.peach })
hl("ModeMsg", { fg = p.fg_dim })
hl("MoreMsg", { fg = p.sage })
hl("Question", { fg = p.lavender })
hl("QuickFixLine", { bg = p.bg_sel })
hl("WildMenu", { fg = p.white, bg = p.bg_sel })

-- Syntax
hl("Comment", { fg = p.comment })
hl("String", { fg = p.sage })
hl("Character", { fg = p.sage })
hl("Number", { fg = p.peach })
hl("Float", { fg = p.peach })
hl("Boolean", { fg = p.peach })
hl("Constant", { fg = p.peach })
hl("Identifier", { fg = p.fg })
hl("Function", { fg = p.lavender })
hl("Statement", { fg = p.orchid })
hl("Conditional", { fg = p.orchid })
hl("Repeat", { fg = p.orchid })
hl("Label", { fg = p.orchid })
hl("Keyword", { fg = p.orchid })
hl("Exception", { fg = p.rose })
hl("Operator", { fg = p.fg_dim })
hl("PreProc", { fg = p.salmon })
hl("Include", { fg = p.salmon })
hl("Define", { fg = p.salmon })
hl("Macro", { fg = p.salmon })
hl("Type", { fg = p.teal })
hl("StorageClass", { fg = p.teal })
hl("Structure", { fg = p.teal })
hl("Typedef", { fg = p.teal })
hl("Special", { fg = p.salmon })
hl("SpecialChar", { fg = p.salmon })
hl("Tag", { fg = p.lavender })
hl("Delimiter", { fg = p.fg_dim })
hl("SpecialComment", { fg = p.comment, bold = true })
hl("Debug", { fg = p.rose })
hl("Underlined", { underline = true })
hl("Error", { fg = p.rose })
hl("Todo", { fg = p.bg, bg = p.peach, bold = true })

-- Treesitter (most @-groups default-link to the bases above)
hl("@variable", { fg = p.fg })
hl("@variable.builtin", { fg = p.salmon })
hl("@variable.parameter", { fg = p.fg })
hl("@variable.member", { fg = p.lavender_br })
hl("@property", { fg = p.lavender_br })
hl("@constructor", { fg = p.teal })
hl("@function.builtin", { fg = p.lavender })
hl("@string.escape", { fg = p.salmon })
hl("@punctuation.bracket", { fg = p.fg_dim })
hl("@punctuation.delimiter", { fg = p.fg_dim })
hl("@tag.attribute", { fg = p.peach })
hl("@markup.heading", { fg = p.lavender_br, bold = true })
hl("@markup.link", { fg = p.teal, underline = true })
hl("@markup.raw", { fg = p.sage })

-- Diagnostics
hl("DiagnosticError", { fg = p.rose })
hl("DiagnosticWarn", { fg = p.peach })
hl("DiagnosticInfo", { fg = p.lavender })
hl("DiagnosticHint", { fg = p.sage })
hl("DiagnosticUnderlineError", { undercurl = true, sp = p.rose })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = p.peach })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = p.lavender })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = p.sage })

-- Diff / git
hl("DiffAdd", { fg = p.sage, bg = "NONE" })
hl("DiffChange", { fg = p.peach, bg = "NONE" })
hl("DiffDelete", { fg = p.rose, bg = "NONE" })
hl("DiffText", { fg = p.peach_br, bg = p.bg_sel })
hl("Added", { fg = p.sage })
hl("Changed", { fg = p.peach })
hl("Removed", { fg = p.rose })
hl("GitSignsAdd", { fg = p.sage })
hl("GitSignsChange", { fg = p.peach })
hl("GitSignsDelete", { fg = p.rose })

-- Spell
hl("SpellBad", { undercurl = true, sp = p.rose })
hl("SpellCap", { undercurl = true, sp = p.peach })
hl("SpellLocal", { undercurl = true, sp = p.sage })
hl("SpellRare", { undercurl = true, sp = p.lavender })

-- Telescope
hl("TelescopeBorder", { fg = p.gray })
hl("TelescopePromptPrefix", { fg = p.orchid })
hl("TelescopeSelection", { bg = p.bg_sel })
hl("TelescopeMatching", { fg = p.peach, bold = true })

-- Embedded terminal
vim.g.terminal_color_0 = p.bg
vim.g.terminal_color_1 = p.rose
vim.g.terminal_color_2 = p.sage
vim.g.terminal_color_3 = p.peach
vim.g.terminal_color_4 = p.lavender
vim.g.terminal_color_5 = p.orchid
vim.g.terminal_color_6 = p.teal
vim.g.terminal_color_7 = p.fg
vim.g.terminal_color_8 = p.gray
vim.g.terminal_color_9 = p.rose_br
vim.g.terminal_color_10 = p.sage_br
vim.g.terminal_color_11 = p.peach_br
vim.g.terminal_color_12 = p.lavender_br
vim.g.terminal_color_13 = p.orchid_br
vim.g.terminal_color_14 = "#BEE2E7"
vim.g.terminal_color_15 = p.white
