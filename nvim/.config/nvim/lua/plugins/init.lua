local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  -- package_root = require("packer.util").join_paths(vim.fn.stdpath "data", "lvim", "pack"),
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

return require("packer").startup(function(use)
  -- packer nvim ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {"wbthomason/packer.nvim", opt = true}

  -- miscellaneous & required for other plugins --------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {"nvim-lua/popup.nvim"}
  use {"nvim-lua/plenary.nvim"}
  use {
    "kyazdani42/nvim-web-devicons",
    opt = true,
    config = function()
      require("plugins.configs.web-devicons").config()
    end,
  }
  use {"tami5/sql.nvim"}

  -- LSP, Syntax, Autocompletion & Linter ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp").config()
      require("lsp.languages")
    end,
  }
  use{
    "kabouzeid/nvim-lspinstall",
    config = function()
      require("lspinstall").setup()
    end,
  }
  --[[ use {
    "hrsh7th/nvim-compe",
    config = function()
      require("plugins.configs.compe").config()
    end,
  } ]]
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter").config()
    end,
  }
  use {
    "mfussenegger/nvim-lint",
    config = function()
      require("plugins.configs.nvim-lint").config()
    end,
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
  }
  use {
    "tamago324/nlsp-settings.nvim",
  }

  -- Telescope & Telescope Extensions ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("plugins.configs.telescope").config()
    end,
  }
  use {"nvim-telescope/telescope-fzy-native.nvim"} -- better sorter
  use {"nvim-telescope/telescope-media-files.nvim"} -- media previewer
  use {"nvim-telescope/telescope-frecency.nvim"} -- ai score search

  -- File Explorer ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.configs.nvimtree").config()
    end,
  }

  -- allow nvim to recognize ftplugins ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {"tjdevries/astronauta.nvim"}


  -- Autopairs ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.configs.autopairs").config()
    end
  }


  -- Snippets ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {"hrsh7th/vim-vsnip", event = "InsertEnter"}
  use {"rafamadriz/friendly-snippets", event = "InsertEnter"}

  -- Comments ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {
    "b3nj5m1n/kommentary",
    config = function()
      require("plugins.configs.kommentary").config()
    end,
  }

  -- Colorscheme -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {
    "glepnir/zephyr-nvim",
    branch = "main",
    config = function()
      require("themes.zephyr-nvim")
    end,
  }

  -- Aesthetics --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    config = function()
      require("plugins.configs.galaxyline")
    end,
  }
  use {
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("plugins.configs.bufferline").config()
    end,
  }

  -- Colorizer ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  --[[ use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  } ]]
  -- *** DONT NEED ANYMORE. LSP DOC HIGHLIGHT ALR COVER THIS

  -- Movement ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {
    "phaazon/hop.nvim",
    config = function()
      require("plugins.configs.hop").config()
    end,
  }
  use {
     "ggandor/lightspeed.nvim",
     config = function()
       require("plugins.configs.lightspeed").config()
     end,
  }

  -- Smooth Scroll -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {
    "karb94/neoscroll.nvim",
    config = function()
      require("plugins.configs.neoscroll").config()
    end,
  }

  -- Tab Out -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  use {
    "abecodes/tabout.nvim",
    config = function()
      require("plugins.configs.tabout").config()
    end,
    wants = {'nvim-treesitter'},
  }

  -- Startup Time ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  --[[ use {
    "henriquehbr/nvim-startup.lua",
    config = function()
      require'nvim-startup'
    end,
  } ]]


end)



