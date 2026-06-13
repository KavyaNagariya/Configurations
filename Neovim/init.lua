-------------------------------------------------
-- 1. Basic UI and Editor Settings
-------------------------------------------------

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.showcmd = true

vim.g.mapleader = " "

-- Quick escape using jk
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Alternative for Visual Block mode (Windows terminals intercept Ctrl+V)
vim.keymap.set("n", "<leader>v", "<C-v>", { noremap = true, desc = "Visual Block Mode" })

-------------------------------------------------
-- 2. Lazy.nvim Setup
-------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------
-- 3. Plugins
-------------------------------------------------

require("lazy").setup({

  -- LSP Config and Mason bridge 
  "neovim/nvim-lspconfig",
  
  -- Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "clangd",
          "lua_ls",
          "rust_analyzer",
          "ts_ls",
          "vimls",
          "zls",
          "gopls",
          "html",
          "cssls",
        },
        automatic_installation = true,
      })
    end,
  },

  	
  -- Auto Brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Catppuccin theme
  {
      "catppuccin/nvim", name = "catppuccin", priority = 1000,
      config = function()
          require("catppuccin").setup()
          vim.cmd.colorscheme "catppuccin"
      end
  },
  -- Tokyo Night
  {
      "folke/tokyonight.nvim",
      priority = 1000,
  },
  -- Dracula
  {
      "Mofiqul/dracula.nvim",
      priority = 1000,
  },
  -- One Dark
  {
      "navarasu/onedark.nvim",
      priority = 1000,
  },
  -- Monokai Pro
  {
      "tanvirtin/monokai.nvim",
      priority = 1000,
  },
  -- Nightfox
  {
      "EdenEast/nightfox.nvim",
      priority = 1000,
  },
  -- Telescope
  {
      'nvim-telescope/telescope.nvim', branch = 'master',
      dependencies = {'nvim-lua/plenary.nvim'},
      config = function()
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<leader>s", builtin.find_files, {})
          vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      end
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end
      configs.setup({
        ensure_installed = {
          "c",
          "cpp",
          "python",
          "lua",
          "rust",
          "typescript",
          "tsx",
          "javascript",
          "vim",
          "vimdoc",
          "zig",
          "go",
          "html",
          "css",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  -- Neotree
  {
      'nvim-neo-tree/neo-tree.nvim',
      branch = "v3.x",
      dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
      },
      config = function()
          vim.keymap.set('n', '<C-q>', ':Neotree toggle left<CR>', { silent = true })
          vim.keymap.set('n', '<C-z>', ':Neotree focus left<CR>', { silent = true })
      end
  },
  -- Lualine
  {
      "nvim-lualine/lualine.nvim",
      config = function()
          require('lualine').setup({
            options = {
              theme = 'auto'
            }
          })
      end
  },
  -- Vim be good game
  {
      'ThePrimeagen/vim-be-good'
  },
})

-------------------------------------------------
-- 4. LSP Configuration
-------------------------------------------------

-- Configure server-specific settings if needed
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

-- List of servers to enable
local servers = {
  "pyright",
  "clangd",
  "lua_ls",
  "rust_analyzer",
  "ts_ls",
  "vimls",
  "zls",
  "gopls",
  "html",
  "cssls",
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-------------------------------------------------
-- 5. LSP Keybindings
-------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-------------------------------------------------
-- 6. Status Line LSP Indicator
-------------------------------------------------

function LspStatus()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if next(clients) == nil then
    return "No LSP"
  end
  local msg = ""
  for _, client in ipairs(clients) do
    msg = msg .. client.name .. " "
  end
  return "LSP: " .. msg
end

vim.opt.statusline = "%f %m %r %= %{v:lua.LspStatus()} %y %p%% %l:%c"

-------------------------------------------------
-- 7. Theme Switcher
-------------------------------------------------

local themes = {
    "catppuccin",
    "tokyonight",
    "dracula",
    "onedark",
    "monokai",
    "nightfox",
}

local theme_file = vim.fn.stdpath("data") .. "/theme.txt"
local current_theme = 1

local function load_theme()
    local f = io.open(theme_file, "r")
    if f then
        local saved = f:read("*a")
        f:close()
        for i, t in ipairs(themes) do
            if t == saved then
                current_theme = i
                break
            end
        end
    end
end

local function save_theme()
    local f = io.open(theme_file, "w")
    if f then
        f:write(themes[current_theme])
        f:close()
    end
end

load_theme()
vim.cmd.colorscheme(themes[current_theme])

vim.keymap.set("n", "<leader>ct", function()
    current_theme = current_theme % #themes + 1
    vim.cmd.colorscheme(themes[current_theme])
    save_theme()
    vim.notify("Theme: " .. themes[current_theme], vim.log.levels.INFO, { title = "Theme Switcher" })
end, { noremap = true, silent = true })

