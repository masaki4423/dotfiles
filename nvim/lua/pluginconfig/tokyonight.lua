require("tokyonight").setup({
    style = "moon",
    transparent = true,
    styles = {
        comments = { bold = true },
        sidebars = "transparent",
    },
    on_highlights = function(hl, c)
        hl.LineNr = {
            fg = '#636da6',
        }
    end
})
vim.cmd[[colorscheme tokyonight]]
