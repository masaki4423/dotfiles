-- 行番号表示
vim.api.nvim_win_set_option(0, "number", true)

-- タブを空白4文字に変更
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- ウィンドウ垂直分割時、新しいファイルは右に開く
vim.opt.splitright = true

-- ウィンドウ水平分割時、新しいファイルは下に開く
vim.opt.splitbelow = true

-- TrueColorを有効化
vim.opt.termguicolors = true

-- yankしたらシステムのクリップボードにもyank
vim.opt.clipboard:append{'unnamedplus'}

-- ポップアップメニューを透過
vim.opt.pumblend=20
