local group = vim.api.nvim_create_augroup("user_autocmd", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    command = "norm zz",
    group = group,
    desc = "Center window on cursor when entering insert mode"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e",
    group = group,
    desc = "Remove trailing spaces"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    group = group,
    desc = "Run formatter on save",
    callback = function(_)
        vim.lsp.buf.format({
            options = { insertFinalNewline = true, trimFinalNewlines = true },
            filter = function(client)
                return client.name ~= "html"
                    and client.name ~= "tsserver"
            end,
            async = false
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "Makefile", "*.go", "*.gomod" },
    command = "setlocal shiftwidth=4 tabstop=4 noexpandtab softtabstop=0",
    group = group,
    desc = "Set tabs as default in some files"
})

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { ".*html", "*.css", "*.js", "*.ts" },
--     command = "setlocal shiftwidth=2 tabstop=2 noexpandtab softtabstop=0",
--     group = group,
--     desc = "Set tabs to width 2 in web stuff"
-- })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "haskell", "lhaskell" },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
    group = group,
    desc = "Haskell uses 2 spaces apparently"
})
