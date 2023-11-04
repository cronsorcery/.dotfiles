vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        -- Keybindings
        local bufopts = { buffer = event.buf, remap = false }

        vim.keymap.set('n', 'g<S-d>', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', '<S-k>', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        -- TODO: check if possible to use w/ telescope for preview
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space><S-d>', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
        -- Open diagnostics in a window
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
    end
})

-- https://github.com/hrsh7th/nvim-cmp
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        -- Completion pop-up window style
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-c>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },  -- https://github.com/saadparwaiz1/cmp_luasnip
        { name = 'nvim_lua' }, -- https://github.com/hrsh7th/cmp-nvim-lua
        { name = 'buffer' },   -- https://github.com/hrsh7th/cmp-buffer
        { name = 'path' },     -- https://github.com/hrsh7th/cmp-path
        { name = 'git' },      -- https://github.com/petertriho/cmp-git
    }),
})

-- https://github.com/hrsh7th/cmp-cmdline
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' },
            },
        },
    })
})

require('cmp_git').setup({
    github = {
        hosts = { 'github.com' },
    },
    gitlab = {
        hosts = {},
    },
})

local lspconfig = require('lspconfig')
local default_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        -- LSPs
        'lua_ls',
        'terraformls',
        'bashls',
        'pyright',
        'gopls',
        -- 'yamlls',
        'ansiblels',
        'sqlls',
        'dockerls',
        'html',
        -- 'tailwindcss',
        'bicep',
    },
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = default_capabilities
            })
        end,
        ['lua_ls'] = function()
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                    },
                },
            })
        end,
        ['bashls'] = function()
            lspconfig.bashls.setup({
                settings = {
                    bashIde = {
                        shellcheckArguments = '--enable=all',
                    },
                },
            })
        end
    },
})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = 'Diagnostics:',
        prefix = '!> ',
    },
})

-- If lsp acts up, use:
-- local lspconfig = require('lspconfig')
-- local get_servers = require('mason-lspconfig').get_installed_servers

-- for _, server_name in ipairs(get_servers()) do
--   lspconfig[server_name].setup({
--     capabilities = lsp_capabilities,
--   })
-- end
