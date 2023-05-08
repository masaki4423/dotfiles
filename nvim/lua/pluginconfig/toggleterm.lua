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
    },
})
