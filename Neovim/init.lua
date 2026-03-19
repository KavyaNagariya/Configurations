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

vim.g.mapleader = " "

-- Quick escape using jk
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

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

  -- LSP Config
  "neovim/nvim-lspconfig",

  -- Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
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
  -- Telescope
  {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = {'nvim-lua/plenary.nvim'},
      config = function()
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<leader>s", builtin.find_files, {})
          vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      end
  },
  -- Treesitter
 --[[ {
        'nvim-treesitter/nvim-treesitter', 
         build = ":TSUpdate",
         config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {"c", "javascript", "python", "lua"},
            highlight = { enable = true },
            indent = { enable = true },
        })
        end
  },]]
  {
      'nvim-neo-tree/neo-tree.nvim',
      branch = "v3.x",
      dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
      },
      config = function()
          vim.keymap.set('n', '<C-q>', ':Neotree filesystem reveal left<CR>', {})
      end
  },
  {
      "nvim-lualine/lualine.nvim",
      config = function()
          require('lualine').setup({
            options = {
              theme = 'dracula'
            }
          })
      end
  },
})

-------------------------------------------------
-- 4. LSP Configuration
-------------------------------------------------

vim.lsp.config("pyright", {})
vim.lsp.enable("pyright")

vim.lsp.config("clangd", {})
vim.lsp.enable("clangd")

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

