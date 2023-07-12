require("flash").setup({
  modes = {
      char = {
          enabled = false,
      },
  },
})

vim.keymap.set({ "n", "x", "o" }, "<space>", function()
    require("flash").jump()
end)
