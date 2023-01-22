require("neo-tree").setup({
    close_if_last_window = true,
    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    },
})

-- NeoVim起動時に起動
vim.api.nvim_create_autocmd("VimEnter", {
    command = "Neotree toggle action=show"
})
