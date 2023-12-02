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

local lspconfig = require('lspconfig')

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'bashls',
        'pyright',
        'gopls',
        'hls',
        'sqlls',
        'html',
        'tailwindcss',
        'tsserver',
        'dockerls',
        'yamlls',
        'azure_pipelines_ls',
        'ansiblels',
        'bicep',
        'terraformls',
    },
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            })
        end,
        ['lua_ls'] = function()
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                            },
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
        end,
        -- Real ominous type shit config
        ['azure_pipelines_ls'] = function()
            lspconfig.azure_pipelines_ls.setup({
                settings = {
                    yaml = {
                        schemas = {
                            ["https://raw.githubusercontent.com/Microsoft/azure-pipelines-vscode/main/service-schema.json"] = {
                                "/azure-pipeline*.y*l",
                                "/*.azure*",
                            },
                        },
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
