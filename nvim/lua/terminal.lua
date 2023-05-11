-- Windowsを使用している場合はデフォルトのターミナルをPowerShellに設定
if vim.loop.os_uname().sysname == "Windows_NT" then
	vim.opt.shell = vim.fn.executable "pwsh" and "pwsh" or "powershell"
    vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = "*",
	command = "set nonumber | startinsert",
})
-- ターミナルモード時はESCを押下でインサートモードからターミナルノーマルモードに移行させるキーマップ
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { silent = true })
