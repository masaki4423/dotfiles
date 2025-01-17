-- 絶対行番号と相対行番号の表示
vim.api.nvim_win_set_option(0, "number", true)
vim.api.nvim_win_set_option(0, "relativenumber", true)

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

-- ステータスラインを分割させない
vim.opt.laststatus = 3

-- 検索時のハイライトを消すキーマッピング
vim.keymap.set("n", "<ESC><ESC>", ":nohlsearch<CR>", {silent = true})

-- Leaderキーを変更
vim.g.mapleader = ","

