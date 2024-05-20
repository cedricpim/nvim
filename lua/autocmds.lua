local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local user_group = augroup("usergroup", { clear = true })

autocmd("FocusGained", {
  desc = "Check if file changed when its window is focus, more eager than 'autoread'",
  group = user_group,
  pattern = "*",
  callback = function() vim.api.nvim_command('checktime') end,
})

autocmd({ "BufWritePre", "FileWritePre" }, {
  desc = "Create missing parent directories",
  group = user_group,
  pattern = "*",
  callback = function()
    vim.api.nvim_command("silent! call mkdir(expand('<afile>:p:h'), 'p')")
  end,
})

local toggle_relative_number = augroup("toggle_relative_number", { clear = true })
autocmd("InsertEnter", {
  desc = "Use absolut line numbers",
  group = toggle_relative_number,
  pattern = "*",
  command = "setlocal norelativenumber"
})
autocmd("InsertLeave", {
  desc = "Use relative line numbers",
  group = toggle_relative_number,
  pattern = "*",
  command = "setlocal relativenumber"
})

local user_persistent_undo = augroup("user_persistent_undo", { clear = true })
autocmd("BufWritePre", { desc = "Do not create undo file", group = user_persistent_undo, pattern = "/tmp/*", command = "setlocal noundofile" })
autocmd("BufWritePre", { desc = "Do not create undo file", group = user_persistent_undo, pattern = "COMMIT_EDITMSG", command = "setlocal noundofile" })
autocmd("BufWritePre", { desc = "Do not create undo file", group = user_persistent_undo, pattern = "MERGE_MSG", command = "setlocal noundofile" })
autocmd("BufWritePre", { desc = "Do not create undo file", group = user_persistent_undo, pattern = "*.tmp", command = "setlocal noundofile" })
autocmd("BufWritePre", { desc = "Do not create undo file", group = user_persistent_undo, pattern = "*.bak", command = "setlocal noundofile" })

local user_secure = augroup("user_secure", { clear = true })
autocmd({ "BufNewFile", "BufReadPre" }, {
  desc = "Disable swap/undo/viminfo/shada files in temp directories or shm",
  group = user_secure,
  pattern = { "/tmp/*", vim.env.TMPDIR .. "/*", "*/shm/*", "/private/var/*", ".vault.vim" },
  command = "setlocal noswapfile noundofile nobackup nowritebackup viminfo= shada="
})

autocmd("FileType", {
  desc = "Disable autocomplete on CSVs",
  pattern = "csv",
  callback = function()
    require('cmp').setup.buffer { enabled = false }
  end,
})
