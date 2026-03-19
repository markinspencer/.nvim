# Neovim Config

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

Leader key: `Space`

## Keybinds

### General

| Key             | Mode          | Action                          |
| --------------- | ------------- | ------------------------------- |
| `Space + pv`    | n             | Open file explorer (netrw)      |
| `Space + Space` | n             | Source current file             |
| `Space + s`     | n             | Substitute word under cursor    |
| `Space + x`     | n             | Make file executable (chmod +x) |
| `Ctrl + s`      | n, i, v, x, s | Save file                       |
| `Q`             | n             | Disabled (nop)                  |

### Navigation

| Key        | Mode | Action                             |
| ---------- | ---- | ---------------------------------- |
| `Ctrl + d` | n    | Half page down (centered)          |
| `Ctrl + u` | n    | Half page up (centered)            |
| `n`        | n    | Next search result (centered)      |
| `N`        | n    | Prev search result (centered)      |
| `J`        | n    | Join lines (cursor stays in place) |

### Editing

| Key   | Mode | Action              |
| ----- | ---- | ------------------- |
| `J`   | v    | Move selection down |
| `K`   | v    | Move selection up   |
| `=ap` | n    | Format paragraph    |

### Clipboard & Registers

| Key         | Mode | Action                              |
| ----------- | ---- | ----------------------------------- |
| `Space + p` | x    | Paste without yanking replaced text |
| `Space + y` | n, v | Yank to system clipboard            |
| `Space + Y` | n    | Yank line to system clipboard       |
| `Space + d` | n, v | Delete to void register             |

### Quickfix & Location List

| Key         | Mode | Action                  |
| ----------- | ---- | ----------------------- |
| `Ctrl + k`  | n    | Next quickfix item      |
| `Ctrl + j`  | n    | Prev quickfix item      |
| `Space + k` | n    | Next location list item |
| `Space + j` | n    | Prev location list item |

### Go Error Handling Snippets

| Key          | Mode | Action                                       |
| ------------ | ---- | -------------------------------------------- |
| `Space + ee` | n    | Insert `if err != nil { return err }`        |
| `Space + ea` | n    | Insert `assert.NoError(err, "")`             |
| `Space + ef` | n    | Insert `if err != nil { log.Fatalf(...) }`   |
| `Space + el` | n    | Insert `if err != nil { logger.Error(...) }` |

### LSP

| Key           | Mode | Action                |
| ------------- | ---- | --------------------- |
| `gd`          | n    | Go to definition      |
| `K`           | n    | Hover info            |
| `Space + vws` | n    | Workspace symbols     |
| `Space + vd`  | n    | View diagnostic float |
| `Space + vca` | n    | Code action           |
| `Space + vrr` | n    | View references       |
| `Space + vrn` | n    | Rename symbol         |
| `Ctrl + h`    | i    | Signature help        |
| `[d`          | n    | Next diagnostic       |
| `]d`          | n    | Prev diagnostic       |
| `Space + zig` | n    | Restart LSP           |

### Telescope

| Key           | Mode | Action                 |
| ------------- | ---- | ---------------------- |
| `Space + pf`  | n    | Find files             |
| `Ctrl + p`    | n    | Find git files         |
| `Space + pws` | n    | Grep word under cursor |
| `Space + pWs` | n    | Grep WORD under cursor |
| `Space + ps`  | n    | Grep string (prompted) |
| `Space + vh`  | n    | View help tags         |

### Harpoon

| Key                        | Mode | Action                       |
| -------------------------- | ---- | ---------------------------- |
| `Space + a`                | n    | Add file to harpoon list     |
| `Space + A`                | n    | Prepend file to harpoon list |
| `Ctrl + e`                 | n    | Toggle harpoon quick menu    |
| `Alt + 1` to `Alt + 6`     | n    | Set current file at slot 1-6 |
| `Space + 1` to `Space + 6` | n    | Navigate to harpoon slot 1-6 |

### Git (Fugitive)

| Key          | Mode | Action                                  |
| ------------ | ---- | --------------------------------------- |
| `Space + gs` | n    | Git status                              |
| `Space + p`  | n    | Git push (in fugitive buffer)           |
| `Space + P`  | n    | Git pull --rebase (in fugitive buffer)  |
| `Space + t`  | n    | Git push -u origin (in fugitive buffer) |
| `Space + uc` | n    | Undo last commit (keep changes)         |
| `Space + st` | n    | Git stash                               |
| `Space + sp` | n    | Git stash pop                           |
| `gu`         | n    | Diffget upstream (left)                 |
| `gh`         | n    | Diffget head (right)                    |

### Debug (DAP)

| Key          | Mode | Action                     |
| ------------ | ---- | -------------------------- |
| `F8`         | n    | Continue                   |
| `F10`        | n    | Step over                  |
| `F11`        | n    | Step into                  |
| `F12`        | n    | Step out                   |
| `Space + b`  | n    | Toggle breakpoint          |
| `Space + B`  | n    | Set conditional breakpoint |
| `Space + dr` | n    | Toggle REPL UI             |
| `Space + ds` | n    | Toggle stacks UI           |
| `Space + dw` | n    | Toggle watches UI          |
| `Space + db` | n    | Toggle breakpoints UI      |
| `Space + dS` | n    | Toggle scopes UI           |
| `Space + dc` | n    | Toggle console UI          |

### Testing (Neotest)

| Key          | Mode | Action                |
| ------------ | ---- | --------------------- |
| `Space + tr` | n    | Run nearest test      |
| `Space + tv` | n    | Toggle test summary   |
| `Space + ts` | n    | Run test suite        |
| `Space + td` | n    | Debug nearest test    |
| `Space + to` | n    | Open test output      |
| `Space + ta` | n    | Attach to test output |

### Trouble

| Key          | Mode | Action            |
| ------------ | ---- | ----------------- |
| `Space + tt` | n    | Toggle trouble    |
| `[t`         | n    | Next trouble item |
| `]t`         | n    | Prev trouble item |

### Snippets (LuaSnip)

| Key        | Mode | Action                   |
| ---------- | ---- | ------------------------ |
| `Alt + s`  | i    | Expand snippet           |
| `Alt + j`  | i, s | Jump forward in snippet  |
| `Alt + k`  | i, s | Jump backward in snippet |
| `Ctrl + E` | i, s | Change snippet choice    |

### Formatting

| Key         | Mode | Action                       |
| ----------- | ---- | ---------------------------- |
| `Space + f` | n    | Format buffer (conform.nvim) |

### Undo Tree

| Key         | Mode | Action           |
| ----------- | ---- | ---------------- |
| `Space + u` | n    | Toggle undo tree |

### Zen Mode

| Key          | Mode | Action                          |
| ------------ | ---- | ------------------------------- |
| `Space + zz` | n    | Zen mode (with line numbers)    |
| `Space + zZ` | n    | Zen mode (without line numbers) |

## Plugins

- **lazy.nvim** - Plugin manager
- **telescope.nvim** - Fuzzy finder
- **harpoon** - Quick file navigation
- **treesitter** - Syntax highlighting & parsing
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/DAP installer
- **nvim-cmp** - Autocompletion
- **LuaSnip** - Snippet engine
- **conform.nvim** - Code formatting
- **vim-fugitive** - Git integration
- **trouble.nvim** - Diagnostics list
- **undotree** - Undo history visualizer
- **nvim-dap** - Debug adapter protocol
- **neotest** - Testing framework
- **zen-mode.nvim** - Distraction-free editing
- **cloak.nvim** - Hide sensitive values in .env files
- **which-key.nvim** - Keybind hints popup
- **rose-pine** - Color scheme
