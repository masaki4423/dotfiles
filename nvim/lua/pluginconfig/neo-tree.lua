require("neo-tree").setup({
    close_if_last_window = true,
    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    },
    event_handlers = {
        {
            event = "file_opened",
            handler = function(file_path)
                require("neo-tree").close_all()
            end
        },
    },
})

vim.keymap.set("n", "gn", "<Cmd>NeoTreeRevealToggle<CR>", { noremap = true, silent = true })
