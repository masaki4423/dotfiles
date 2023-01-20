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
end)

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  command = "PackerCompile",
})
