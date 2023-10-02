-- general
lvim.log.level = "warn"
lvim.format_on_save = true
-- Write a function that sets the color scheme based on the time of day


local function getColorScheme()
  local currentTime = os.date("*t")
  local currentHour = currentTime.hour

  local color

  if currentHour >= 6 and currentHour < 12 then
    color = "lunar"
  elseif currentHour >= 12 and currentHour < 18 then
    color = "kanagawa-wave"
  else
    color = "tokyonight"
  end

  return color
end

lvim.colorscheme = getColorScheme()







lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.autotag.enable = true


-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.which_key.mappings["x"] = { ":x<cr>", "Save and Quit" }
lvim.builtin.which_key.mappings["t"] = { ":Twilight<cr>", "Twilight Toggle" }
lvim.builtin.which_key.mappings["z"] = { ":ZenMode<cr>", "Zen Mode" }
lvim.builtin.which_key.mappings["d"] = { "<cmd>Pydocstring<cr>", "Pydocstring" }


-- TMUX
lvim.builtin.which_key.mappings["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" }
lvim.builtin.which_key.mappings["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" }
lvim.builtin.which_key.mappings["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" }
lvim.builtin.which_key.mappings["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Vim Settings
vim.opt.relativenumber = true
vim.api.nvim_set_keymap("n", "<Leader><Space>", ":set hlsearch!<CR>", { noremap = true, silent = true })
-- Delete text without copying replaced text
-- vim.cmd('vnoremap p "_dP')


lvim.builtin.nvimtree.setup.disable_netrw = false



-- Vim Pydocstrings
--/Users/jhch/miniconda3/envs/cortex/bin/doq
-- vim.g.pydocstring_doq_path = "/Users/jhch/mambaforge/envs/qiime2-2022.11/bin/doq"
vim.g.pydocstring_doq_path = "/Users/jhch/miniconda3/bin/doq"
vim.g.pydocstring_formatter = "numpy"
-- Disable pydocstring keybindings and add to which key. This prevents collisions between keybindings
vim.g.pydocstring_enable_mapping = 0

-- Treesitter
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "svelte"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.autotag.enable = true

-- require("lvim.lsp.manager").setup("emmet_ls")


-- Formattter and Linters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact", "javascript", "css", "scss", "html", "svelte" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  { command = "eslint", filetypes = { "typescript", "typescriptreact", "javascript", "html", "svelte" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}

-- Aditional Plugins
-- TODO: Clean these up
lvim.plugins = {

  { "morhetz/gruvbox" },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require('nvim-highlight-colors').setup {}
    end,
  },
  { "tpope/vim-surround" },
  { "ap/vim-css-color" },
  { "heavenshell/vim-pydocstring" },
  { "tpope/vim-fugitive" },
  -- { "folke/tokyonight.nvim" },
  { "sainnhe/gruvbox-material" },
  { "kyazdani42/blue-moon" },
  { "rebelot/kanagawa.nvim" },

  {
    "p00f/nvim-ts-rainbow",
  },
  {
    "windwp/nvim-ts-autotag"
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
      }
    end
  },
  { 'folke/lsp-colors.nvim' },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
      }
    end
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  { "folke/trouble.nvim",   cmd = "TroubleToggle" },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    version = 'v1.*',
  },
  {
    "potamides/pantran.nvim"
  },
  {
    "catppuccin/nvim",
    name = "catppuccin"
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup {
        mapping = { "jk", "jj" },   -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        clear_empty_lines = false,  -- clear line after escaping if there is only whitespace
        keys = "<Esc>",             -- keys used for escaping, if it is a function will use the result everytime
      }
    end,
  },
  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup({ "typescript", "typescriptreact", "javascript", "css", "scss", "python",
  --       "html", "javascriptreact", "svelte" }, {
  --       lowercase = true,
  --       RGB = true, -- #RGB hex codes
  --       RRGGBB = true, -- #RRGGBB hex codes
  --       RRGGBBAA = true, -- #RRGGBBAA hex codes
  --       rgb_fn = true, -- CSS rgb() and rgba() functions
  --       hsl_fn = true, -- CSS hsl() and hsla() functions
  --       css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  --       css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  --     })
  --   end,
  -- },
  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
          plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
        }
      end, 100)
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
    config = function()
      require("copilot_cmp").setup()
    end
  }
}

-- Can not be placed into the config method of the plugins.
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 2, { name = "copilot" })
