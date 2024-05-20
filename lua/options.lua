-- set vim options here (vim.<first_key>.<second_key> = value)

local cache_dir = vim.fn.expand(vim.env.XDG_CACHE_HOME) .. "/nvim"
local data_dir = vim.fn.expand(vim.env.XDG_DATA_HOME) .. "/nvim"

os.execute("mkdir -p " .. cache_dir .. "/swap")
os.execute("mkdir -p " .. cache_dir .. "/undo")
os.execute("mkdir -p " .. cache_dir .. "/backup")
os.execute("mkdir -p " .. cache_dir .. "/view")
os.execute("mkdir -p " .. data_dir .. "/spell")

local options = {
  opt = {
    -- set to true or false etc.
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true, -- sets vim.opt.number
    spell = true, -- sets vim.opt.spell
    signcolumn = "auto", -- sets vim.opt.signcolumn to auto
    wrap = true, -- sets vim.opt.wrap
    magic = true, -- For regular expressions turn magic on
    swapfile = false,
    modeline = false, -- disable modelines explicitly
    modelines = 0, -- ensure modelines do not run
    wildignorecase = true,
    wildignore = {
      ".git",
      ".hg",
      ".svn",
      ".stversions",
      "*.pyc",
      "*.spl",
      "*.o",
      "*.out",
      "*~",
      "%*",
      "*.jpg",
      "*.jpeg",
      "*.png",
      "*.gif",
      "*.zip",
      "tmp/**",
    },
    directory = { cache_dir, cache_dir .. "/swap//", "~/tmp", "/var/tmp", "/tmp" },
    undodir = { cache_dir, cache_dir .. "/undo//", "~/tmp", "/var/tmp", "/tmp" },
    backupdir = { cache_dir, cache_dir .. "/backup//", "~/tmp", "/var/tmp", "/tmp" },
    viewdir = cache_dir .. "/view//",
    spellfile = data_dir .. "/spell/en.utf-8.add",
    history = 2000,
    shada = "!,'300,<50,@100,s10,h",
    backupskip = { "/tmp/*", vim.env.TMPDIR .. "/*", "*/shm/*", "/private/var/*", ".vault.vim" }, -- Secure sensitive information, disable backup files in temp directories
    breakindentopt = "shift:2,min:20",
    ttimeoutlen = 10, -- Time out on key codes
    list = true,
    fillchars = "vert:│,horiz:─,eob:\\", -- add a bar for vertical splits and a dash for horizontal splits
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
  },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
