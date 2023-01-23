vim.cmd.packadd "packer.nvim"

require("packer").startup(function()
    use 'wbthomason/packer.nvim'
    -- ColorScheme
    -- use {
        -- 'shaunsingh/nord.nvim',
        -- config = function()
            -- require("pluginconfig/nord")
        -- end
    -- }

    use {
        'folke/tokyonight.nvim',
        config = function()
            require("pluginconfig/tokyonight")
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
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("pluginconfig/nvim-web-devicons")
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

    use {
        "williamboman/mason.nvim",
        config = function()
            require("pluginconfig/mason")
        end
    }

    use {
        "williamboman/mason-lspconfig",
        config = function()
            require("pluginconfig/mason-lspconfig")
        end
    }

    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    use "onsails/lspkind.nvim"
    use {
        "hrsh7th/nvim-cmp",
        config = function()
            require("pluginconfig/nvim-cmp")
        end
    }

    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require("pluginconfig/lspsaga")
        end
    }

    use {
        "j-hui/fidget.nvim",
        config = function()
            require("pluginconfig/fidget")
        end
    }

end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
