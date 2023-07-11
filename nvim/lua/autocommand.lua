local lineNumberToggle = vim.api.nvim_create_augroup("LineNumber", { clear = true })

vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave", "WinEnter"}, {
    pattern = {"*"},
    command = "if &nu && mode() != \"i\" | set rnu | endif",
    group = lineNumberToggle,
})

vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter", "WinLeave"}, {
    pattern = {"*"},
    command = "if &nu | set nornu | endif",
    group = lineNumberToggle,
})
