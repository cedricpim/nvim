-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec

local cache_dir = vim.fn.expand(vim.env.XDG_CACHE_HOME) .. "/nvim"
local data_dir = vim.fn.expand(vim.env.XDG_DATA_HOME) .. "/nvim"

os.execute("mkdir -p " .. cache_dir .. "/swap")
os.execute("mkdir -p " .. cache_dir .. "/undo")
os.execute("mkdir -p " .. cache_dir .. "/backup")
os.execute("mkdir -p " .. cache_dir .. "/view")
os.execute("mkdir -p " .. data_dir .. "/spell")

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
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
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<leader>bD"] = {
          function()
            require("astronvim.utils.status").heirline.buffer_picker(
              function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        ["<leader>b"] = { name = "Buffers" },
        ["<leader>pf"] = { function() require("user.utils").copy(vim.fn.expand "%:p") end, desc = "Yank full path" },
        ["<leader>pF"] = {
          function() require("user.utils").copy(vim.fn.expand "%:p" .. ":" .. vim.fn.line ".") end,
          desc = "Yank full path with line",
        },
        ["<leader>pr"] = { function() require("user.utils").copy(vim.fn.expand "%") end, desc = "Yank relative path" },
        ["<leader>pR"] = {
          function() require("user.utils").copy(vim.fn.expand "%" .. ":" .. vim.fn.line ".") end,
          desc = "Yank relative path with line",
        },
        ["<leader>bX"] = {
          function() require("astronvim.utils.buffer").close_all(false, false) end,
          desc = "Close all buffers without saving",
        },
        ["<leader>m"] = { "<cmd>MundoToggle<cr>", desc = "MundoToggle" },
        ["<leader>fj"] = { "<cmd>AnyJump<cr>", desc = "Show definition references" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
      x = {
        ["v"] = { "<Plug>(expand_region_expand)" },
        ["V"] = { "<Plug>(expand_region_shrink)" },
        ["<leader>fj"] = { "<cmd>AnyJump<cr>", desc = "Show definition references" },
      },
    },
  },
}
