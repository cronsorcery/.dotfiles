-- Comment out selected text if Commentary is installed
if vim.api.nvim_get_commands({}).Commentary then
    vim.keymap.set("v", "<leader>/", ":Commentary<CR>", { silent = true })
end
