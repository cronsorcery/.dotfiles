local telescope = require('telescope')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

-- Checkout telescope help
-- telescope.setup({
--     defaults = {
--         -- Default configuration for telescope goes here:
--         -- config_key = value,
--         -- ..
--     },
--     pickers = {
--         -- Default configuration for builtin pickers goes here:
--         -- picker_name = {
--         --   picker_config_key = value,
--         --   ...
--         -- }
--         -- Now the picker_config_key will be applied every time you call this
--         -- builtin picker
--     },
--     extensions = {
--         -- Your extension configuration goes here:
--         -- extension_name = {
--         --   extension_config_key = value,
--         -- }
--         -- please take a look at the readme of the extension you want to configure
--     }

-- })

local function with_dropdown(func, theme_config)
    local theme = themes.get_dropdown(theme_config or {})
    return function() return func(theme) end
end

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fp', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fB', with_dropdown(builtin.git_branches), {})
