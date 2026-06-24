-- OpenJai integration for .jai buffers (native Windows build).
--
-- Loaded after rluba/jai.vim's ftplugin, which already provides syntax,
-- indentation, filetype detection and ]]/[[ motions. This adds:
--   * a comment string (jai.vim doesn't set one)
--   * <leader>jb / :OpenJaiBuild  -- compile the current file with OpenJai
--   * <leader>jr / :OpenJaiRun    -- compile, then run in a split terminal
--
-- Paths can be overridden with environment variables or g: globals:
--   OPENJAI / vim.g.openjai_compiler   -> the openjai compiler exe
--   OPENJAI_RUNTIME / vim.g.openjai_runtime -> the runtime manifest
--   OPENJAI_MODULES / vim.g.openjai_modules -> standard modules dir (for #import)
--   vim.g.openjai_mingw_bin            -> MinGW bin dir (linker + runtime DLLs)

local openjai = vim.env.OPENJAI
  or vim.g.openjai_compiler
  or [[C:\Users\Anh\code\open-jai\bootstrap\zig-out\bin\openjai-windows.exe]]
local runtime = vim.env.OPENJAI_RUNTIME
  or vim.g.openjai_runtime
  or [[C:\Users\Anh\code\open-jai\bootstrap\zig-out\lib\openjai_runtime.manifest]]
-- Where the standard library modules (Basic, etc.) live. The compiler otherwise
-- only finds them by walking up from the cwd for a modules/ dir, which fails
-- when editing a project outside the open-jai tree.
local modules = vim.env.OPENJAI_MODULES
  or vim.g.openjai_modules
  or [[C:\Users\Anh\code\open-jai\modules]]
local mingw_bin = vim.g.openjai_mingw_bin or [[C:\msys64\mingw64\bin]]

-- The compiler links against libLLVM-22.dll and shells out to gcc for the final
-- link; produced exes need libgcc/libwinpthread. Make all of that reachable for
-- :make, builds, and the run terminal by ensuring MinGW is on PATH.
if not (vim.env.PATH or ""):find(mingw_bin, 1, true) then
  vim.env.PATH = mingw_bin .. ";" .. (vim.env.PATH or "")
end
vim.env.OPENJAI_CC = vim.env.OPENJAI_CC or (mingw_bin .. [[\gcc.exe]])

vim.bo.commentstring = "// %s"

local function compile(run_after)
  if vim.bo.modified then
    vim.cmd("write")
  end
  local src = vim.fn.expand("%:p")
  -- Put build output in a project bin/ when this file lives in a project
  -- (detected by a .git/bin/build.ps1 marker); otherwise build next to source.
  local root = vim.fs.root(src, { ".git", "bin", "build.ps1" })
  local exe
  if root then
    local bindir = root .. "\\bin"
    vim.fn.mkdir(bindir, "p")
    exe = bindir .. "\\" .. vim.fn.expand("%:t:r") .. ".exe"
  else
    exe = vim.fn.expand("%:p:r") .. ".exe"
  end
  vim.notify("openjai: compiling " .. vim.fn.expand("%:t") .. " ...", vim.log.levels.INFO)

  local result = vim.system(
    { openjai, src, "-o", exe, "--runtime", runtime, "-import_dir", modules },
    { text = true }
  ):wait()

  if result.code ~= 0 then
    local output = (result.stdout or "") .. (result.stderr or "")
    vim.fn.setqflist({}, "r", {
      title = "openjai",
      lines = vim.split(output, "\n", { trimempty = true }),
      -- Match "path:line:col: message" style diagnostics; fall back to raw text.
      efm = [[%f:%l:%c: %m,%f:%l\,%c: %m,%m]],
    })
    vim.cmd("copen")
    vim.notify("openjai: build failed (exit " .. result.code .. ")", vim.log.levels.ERROR)
    return
  end

  vim.cmd("cclose")
  vim.notify("openjai: built " .. vim.fn.fnamemodify(exe, ":t"), vim.log.levels.INFO)
  if run_after then
    vim.cmd("botright vsplit | vertical resize 100 | terminal " .. vim.fn.fnameescape(exe))
    vim.cmd("startinsert")
  end
end

vim.keymap.set("n", "<leader>jb", function() compile(false) end,
  { buffer = true, desc = "[j]ai [b]uild with OpenJai" })
vim.keymap.set("n", "<leader>jr", function() compile(true) end,
  { buffer = true, desc = "[j]ai [r]un (build + run)" })

vim.api.nvim_buf_create_user_command(0, "OpenJaiBuild", function() compile(false) end,
  { desc = "Compile the current .jai file with OpenJai" })
vim.api.nvim_buf_create_user_command(0, "OpenJaiRun", function() compile(true) end,
  { desc = "Compile and run the current .jai file with OpenJai" })
