-- マウス機能のOnOFFコマンド
vim.api.nvim_create_user_command("ToggleMouse", function(opts)
    local mouse_setting = vim.api.nvim_get_option("mouse")
    if mouse_setting == "nvi" then
        print("disable mouse.")
        vim.api.nvim_set_option("mouse", "")
    else
        print("enable mouse.")
        vim.api.nvim_set_option("mouse", "nvi")
    end
end, { nargs = 0 })

vim.keymap.set("n", "<F12>", ":ToggleMouse<CR>", { silent = true })
