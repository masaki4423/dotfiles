require("tokyonight").setup({
    style = "moon",
    transparent = true,
    styles = {
        comments = { bold = true },
        sidebars = "transparent",
    },
    on_colors = function(colors)
        colors.bg_highlight = "#636da6"
    end,
    on_highlights = function(hl, c)
        hl.LspReferenceRead = {
            bg = "#636da6",
        }
        hl.LspReferenceText = {
            bg = "#636da6",
        }
        hl.LspReferenceWrite = {
            bg = "#636da6",
        }
        hl.LineNr = {
            fg = "#636da6",
        }
    end
})
vim.cmd[[colorscheme tokyonight]]
