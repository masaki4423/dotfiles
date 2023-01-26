require("bufferline").setup{
    options = {
        numbers = function(opts)
            return string.format('%s·%s', opts.raise(opts.ordinal), opts.lower(opts.id))
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " "
                    or (e == "warning" and " " or "" )
            s = s .. n .. sym
            end
            return s
        end,
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true
            }
        }
    },
}

vim.keymap.set("n", "<leader>r", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>t", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>c", "<Cmd>BufferLinePickClose<CR>", { noremap = true, silent = true })
