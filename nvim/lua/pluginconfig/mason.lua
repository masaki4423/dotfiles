local mason = require("mason")
local mason_package = require("mason-core.package")
local mason_registry = require("mason-registry")
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

mason.setup({})

local null_sources = {}

mason_registry.refresh()
mason_registry.update()

for _, package in ipairs(mason_registry.get_installed_packages()) do
    local package_categories = package.spec.categories[1]
    if package_categories == mason_package.Cat.Formatter then
        table.insert(null_sources, null_ls.builtins.formatting[package.name])
    end
    if package_categories == mason_package.Cat.Linter then
        table.insert(null_sources, null_ls.builtins.diagnostics[package.name])
    end
end

null_ls.setup({
    sources = null_sources,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
