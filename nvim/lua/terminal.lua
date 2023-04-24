-- Windowsを使用している場合はデフォルトのターミナルをPowerShellに設定
if vim.loop.os_uname().sysname == "Windows_NT" then
	vim.opt.shell = "pwsh"
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = "*",
	command = "set nonumber | startinsert",
})
-- ターミナルモード時はESCを押下でインサートモードからターミナルノーマルモードに移行させるキーマップ
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { silent = true })
