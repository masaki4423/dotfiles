local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- { "wbthomason/packer.nvim" },
    -- ColorScheme
    -- {
    -- 'shaunsingh/nord.nvim',
    -- config = function()
    -- require("pluginconfig/nord")
    -- end
    -- },

    {
        "folke/tokyonight.nvim",
        config = function()
            require("pluginconfig/tokyonight")
        end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("pluginconfig.nvim-colorizer")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
        config = function()
            require("pluginconfig/lualine")
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("pluginconfig/toggleterm")
        end,
    },

    {
        "akinsho/bufferline.nvim",
        version = "v3.*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("pluginconfig/bufferline")
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("pluginconfig/neo-tree")
        end,
    },

    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("pluginconfig/nvim-web-devicons")
        end,
    },

    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("pluginconfig/nvim-scrollbar")
        end,
    },

    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("pluginconfig/nvim-hlslens")
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("pluginconfig/gitsigns")
        end,
    },

    {
        "williamboman/mason.nvim",
        event = { "BufReadPre", "VimEnter" },
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("pluginconfig/mason")
        end,
    },

    {
        "williamboman/mason-lspconfig",
        event = "BufReadPre",
        config = function()
            require("pluginconfig/mason-lspconfig")
        end,
    },

    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    { "onsails/lspkind.nvim" },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("pluginconfig/nvim-cmp")
        end,
    },

    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require("pluginconfig/lspsaga")
        end,
    },

    {
        "j-hui/fidget.nvim",
        config = function()
            require("pluginconfig/fidget")
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
        },
        config = function()
            require("pluginconfig/telescope")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
        config = function()
            require("pluginconfig.nvim-treesitter")
        end,
    },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("pluginconfig.nvim-autopairs")
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("pluginconfig.indent-blankline")
        end,
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("pluginconfig.Comment")
        end,
    },

    {
        'willothy/flatten.nvim',
        config = function()
            require("pluginconfig.flatten")
        end
    },

}

require("lazy").setup(plugins)
