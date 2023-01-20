vim.cmd.packadd "packer.nvim"

require("packer").startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
	        require('lualine').setup({
                    options = {
	                theme = 'everforest'
		    }
	    })
	end
    }

    use {
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            require("toggleterm").setup({
                open_mapping = "<C-j>",
                direction = 'horizontal',
            })
    end}

    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup{}
        end
    }
end)

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  command = "PackerCompile",
})
