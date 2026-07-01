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
  -- Alpha Dashboard
  {
      'goolord/alpha-nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
          local dashboard = require("alpha.themes.dashboard")
          require("alpha").setup(dashboard.config)
      end
  },
  -- Kanagawa
  { "rebelot/kanagawa.nvim", priority = 1000 },
  -- Rose Pine
  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
  -- Gruvbox
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  -- Ayu
  { "Shatur/neovim-ayu", priority = 1000 },
  -- Nord
  { "shaunsingh/nord.nvim", priority = 1000 },
  -- Cyberdream
  { "scottmckendry/cyberdream.nvim", priority = 1000 },
  -- Oxocarbon
  { "nyoom-engineering/oxocarbon.nvim", priority = 1000 },
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
  -- Bufferline
  {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = "nvim-tree/nvim-web-devicons",
      config = function()
          require("bufferline").setup({
              options = {
                  diagnostics = "nvim_lsp",
                  always_show_bufferline = true,
                  show_buffer_close_icons = false,
                  show_close_icon = false,
              }
          })
          -- Keymaps for buffer navigation
          vim.keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Prev Buffer" })
          vim.keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
          vim.keymap.set("n", "<leader>c", "<Cmd>bdelete<CR>", { noremap = true, silent = true, desc = "Close Buffer" })
      end
  },
  -- Vim be good game
  {
      'ThePrimeagen/vim-be-good'
  },
  
  -- Autocompletion Engine (nvim-cmp)
  {
      "hrsh7th/nvim-cmp",
      dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "L3MON4D3/LuaSnip",
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
      },
      config = function()
          local cmp = require("cmp")
          local luasnip = require("luasnip")
          require("luasnip.loaders.from_vscode").lazy_load()

          cmp.setup({
              snippet = {
                  expand = function(args)
                      luasnip.lsp_expand(args.body)
                  end,
              },
              mapping = cmp.mapping.preset.insert({
                  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                  ['<C-f>'] = cmp.mapping.scroll_docs(4),
                  ['<C-Space>'] = cmp.mapping.complete(),
                  ['<C-e>'] = cmp.mapping.abort(),
                  ['<CR>'] = cmp.mapping.confirm({ select = true }),
                  ['<Tab>'] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                          cmp.select_next_item()
                      elseif luasnip.expand_or_jumpable() then
                          luasnip.expand_or_jump()
                      else
                          fallback()
                      end
                  end, { "i", "s" }),
                  ['<S-Tab>'] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                          cmp.select_prev_item()
                      elseif luasnip.jumpable(-1) then
                          luasnip.jump(-1)
                      else
                          fallback()
                      end
                  end, { "i", "s" }),
              }),
              sources = cmp.config.sources({
                  { name = 'nvim_lsp' },
                  { name = 'luasnip' },
              }, {
                  { name = 'buffer' },
                  { name = 'path' },
              })
          })
      end
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

local capabilities = nil
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  capabilities = cmp_nvim_lsp.default_capabilities()
end

for _, server in ipairs(servers) do
  -- Hook up nvim-cmp completion capabilities
  if capabilities then
      vim.lsp.config(server, { capabilities = capabilities })
  end
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
-- 7. Theme Switcher (Telescope)
-------------------------------------------------

local theme_file = vim.fn.stdpath("data") .. "/theme.txt"

local function load_theme()
    local f = io.open(theme_file, "r")
    if f then
        local saved = f:read("*a")
        f:close()
        saved = saved:gsub("%s+", "")
        if saved ~= "" then
            pcall(vim.cmd.colorscheme, saved)
            return
        end
    end
    vim.cmd.colorscheme("catppuccin")
end

load_theme()

vim.keymap.set("n", "<leader>ct", function()
    require("telescope.builtin").colorscheme({
        enable_preview = true,
        attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")

            local function save_and_apply(bufnr)
                local selection = action_state.get_selected_entry()
                actions.close(bufnr)
                if selection then
                    local theme = selection.value
                    vim.cmd.colorscheme(theme)
                    local f = io.open(theme_file, "w")
                    if f then
                        f:write(theme)
                        f:close()
                    end
                    vim.notify("Theme set to: " .. theme, vim.log.levels.INFO)
                end
            end

            map("i", "<CR>", save_and_apply)
            map("n", "<CR>", save_and_apply)
            return true
        end
    })
end, { noremap = true, silent = true, desc = "Theme Switcher" })

