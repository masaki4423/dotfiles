-- ターミナル時は行番号は表示させない。
vim.api.nvim_create_autocmd({"TermOpen"}, {
    pattern = "*",
    command = "setlocal nonumber norelativenumber",
})

-- ターミナル時は挿入モードで起動。
vim.api.nvim_create_autocmd({"TermOpen"}, {
    pattern = "*",
    command = "startinsert",
})
