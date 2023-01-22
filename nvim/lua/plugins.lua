vim.cmd.packadd "packer.nvim"

require("packer").startup(function()
    use 'wbthomason/packer.nvim'
    -- ColorScheme
    use {
        'shaunsingh/nord.nvim',
        config = function()
            require("pluginconfig/nord")
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require("pluginconfig/lualine")
        end
    }

    use {
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            require("pluginconfig/toggleterm")
        end
    }

    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("pluginconfig/bufferline")
        end
    }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", 
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("pluginconfig/neo-tree")
        end
    }

    use {
        "petertriho/nvim-scrollbar",
        config = function()
            require("pluginconfig/nvim-scrollbar")
        end
    }

    use {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("pluginconfig/nvim-hlslens")
        end
    }

    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("pluginconfig/gitsigns")
        end
    }
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
