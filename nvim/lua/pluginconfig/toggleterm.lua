require("toggleterm").setup({
    open_mapping = "<C-j>",
    direction = "float",
    highlights = {
        NormalFloat = {
            link = "FloatBorder",
        },
        FloatBorder = {
            guifg = "#0f689e",
        },
    },
    float_opts = {
        border = "single",
        winblend = 3,
        width = math.floor(vim.o.columns * 0.9),
        height = math.floor(vim.o.lines * 0.9),
    },
})
