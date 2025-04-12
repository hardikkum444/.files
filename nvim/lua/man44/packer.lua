  -- This file can be loaded by calling `lua require('plugins')` from your init.vim

  -- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

  -- So that packer can manage itself
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Telescope baby, for that nice fuzzy finding
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Themes
  use { "ellisonleao/gruvbox.nvim" }
  use { "craftzdog/solarized-osaka.nvim" }
  use { "folke/tokyonight.nvim" }
  use { 'projekt0n/github-nvim-theme', name = 'github-theme' }
  use { "rose-pine/neovim" }
  use {"Shatur/neovim-ayu"}
  use {"blazkowolf/gruber-darker.nvim"}

  -- Treesitter
  use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  -- Other plugins
  use ('ThePrimeagen/harpoon')
  use ('tpope/vim-fugitive')
  use ('ThePrimeagen/vim-be-good')

  -- GCC for comment
  use ('https://github.com/tpope/vim-commentary')

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

  -- LSP
  use {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'}
  use {'neovim/nvim-lspconfig'}
  use {'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {"williamboman/mason.nvim"}
  use {
    "williamboman/mason-lspconfig.nvim",
  }

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Neotree
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }

  -- Codesnap for that nice code snapping
  use {'mistricky/codesnap.nvim', run = 'make'}

  -- Some weird dependency
  use { 'nvim-lua/plenary.nvim' }

  -- None-ls for that formatting and stuff
  use { 'nvimtools/none-ls.nvim'}

  -- Toggle term for toggling that terminal
  use { 'akinsho/toggleterm.nvim' }

  -- For highlighting logs
  use { 'fei6409/log-highlight.nvim' }

  -- For web-dev-icons in neotree
  use {"nvim-tree/nvim-web-devicons"}

end)
