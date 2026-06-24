vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "[p]roject [v]iew (file explorer)" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (cursor stays)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
vim.keymap.set("n", "=ap", "ma=ap'a", { desc = "Format paragraph" })
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "[z]ap: Restart LSP" })

vim.keymap.set("n", "<leader>lt", function()
    vim.cmd [[ PlenaryBustedFile % ]]
end, { desc = "[l]ua [t]est: run plenary test file" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[p]aste without yanking" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank line to clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "[d]elete to void register" })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next [k] location item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev [j] location item" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[s]ubstitute word under cursor" })
vim.keymap.set("n", "<leader>sf", function()
    local node = vim.treesitter.get_node()
    while node do
        if node:type() == "function_declaration" or node:type() == "method_declaration" or node:type() == "function_definition" or node:type() == "procedure_declaration" then
            break
        end
        node = node:parent()
    end
    if not node then
        vim.notify("No function found", vim.log.levels.WARN)
        return
    end
    local start_row = node:start()
    local end_row = node:end_()
    local range = (start_row + 1) .. "," .. (end_row + 1)
    local keys = vim.api.nvim_replace_termcodes(
        ":" .. range .. [[s/\<]] .. "<C-r><C-w>" .. [[\>/]] .. "<C-r><C-w>" .. "/gI<Left><Left><Left>",
        true, false, true
    )
    vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "[s]ubstitute word in [f]unction" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file e[x]ecutable" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror" })
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "[e]rr: if [e]rr return" })
vim.keymap.set("n", "<leader>ea", "oassert.NoError(err, \"\")<Esc>F\";a", { desc = "[e]rr: [a]ssert no error" })
vim.keymap.set("n", "<leader>ef", "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj", { desc = "[e]rr: log.[f]atalf" })
vim.keymap.set("n", "<leader>el", "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i", { desc = "[e]rr: [l]ogger.Error" })

local run_hot_reload_build = function()
    local file_dir = vim.fn.expand("%:p:h")
    local build_file = vim.fs.find("build_hot_reload.bat", { path = file_dir, upward = true })[1]
    if not build_file then
        return
    end

    local root = vim.fs.dirname(build_file)
    vim.notify("Running build_hot_reload.bat", vim.log.levels.INFO)

    local output = {}
    local job = vim.fn.jobstart({ "cmd.exe", "/d", "/s", "/c", '"' .. build_file .. '"' }, {
        cwd = root,
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            vim.list_extend(output, data or {})
        end,
        on_stderr = function(_, data)
            vim.list_extend(output, data or {})
        end,
        on_exit = function(_, code)
            if code == 0 then
                vim.schedule(function()
                    vim.notify("Hot reload build succeeded", vim.log.levels.INFO)
                end)
                return
            end

            vim.schedule(function()
                vim.notify("Hot reload build failed", vim.log.levels.ERROR)
                vim.cmd("botright new")
                vim.bo.buftype = "nofile"
                vim.bo.bufhidden = "wipe"
                vim.bo.swapfile = false
                vim.api.nvim_buf_set_name(0, "hot-reload-build-output")
                vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
            end)
        end,
    })

    if job <= 0 then
        vim.notify("Failed to start build_hot_reload.bat", vim.log.levels.ERROR)
    end
end

vim.keymap.set({"n", "i", "v", "x", "s"}, "<C-s>", function()
    vim.cmd("stopinsert")
    if not vim.bo.modifiable then return end
    local ft = vim.bo.filetype
    local actions_to_run = {}
    if ft == "go" then
        actions_to_run = { "source.organizeImports" }
    elseif ft == "typescript" or ft == "javascript" or ft == "typescriptreact" or ft == "javascriptreact" then
        actions_to_run = { "source.addMissingImports", "source.organizeImports" }
    end
    for _, action_kind in ipairs(actions_to_run) do
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { action_kind }, diagnostics = {} }
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        for _, res in pairs(result or {}) do
            for _, action in pairs(res.result or {}) do
                if action.edit then
                    vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
                elseif action.command then
                    vim.lsp.buf.execute_command(action.command)
                end
            end
        end
    end
    require("conform").format({ bufnr = 0 })
    vim.cmd("w")
    run_hot_reload_build()
end, { desc = "Organize imports + format + save file" })

vim.keymap.set("n", "<leader>uc", function()
    vim.cmd("Git reset --soft HEAD^")
end, { desc = "[u]ndo last [c]ommit (keep changes)" })
vim.keymap.set("n", "<leader>st", "<cmd>Git stash<CR>", { desc = "[s]tash changes" })
vim.keymap.set("n", "<leader>sp", "<cmd>Git stash pop<CR>", { desc = "[s]tash [p]op" })

vim.keymap.set("n", "<leader>o", "o<Esc>k", { desc = "Insert blank line below" })
vim.keymap.set("n", "<leader>O", "O<Esc>j", { desc = "Insert blank line above" })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Source current file" })
