vim.api.nvim_create_autocmd( {"TermOpen"}, {
    pattern = "*",
    command = "set nonumber | startinsert",
})
-- ターミナルモード時はESCを押下でインサートモードからターミナルノーマルモードに移行させるキーマップ
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", {silent=true})
