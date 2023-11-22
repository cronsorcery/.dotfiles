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
    callback = function(_)
        local filetype_exclusions = { "html" }
        for _, value in ipairs(filetype_exclusions) do
            if vim.bo.filetype == value then
                return
            end
        end
        vim.lsp.buf.format({ async = false })
    end,
    group = group,
    desc = "Run formatter on save"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "Makefile", "*.go", "*.gomod" },
    command = "setlocal shiftwidth=4 tabstop=4 noexpandtab softtabstop=0",
    group = group,
    desc = "Set tabs as default in some files"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { ".*html", "*.css", "*.js", "*.ts" },
    command = "setlocal shiftwidth=2 tabstop=2 noexpandtab softtabstop=0",
    group = group,
    desc = "Set tabs to width 2 in web stuff"
})
