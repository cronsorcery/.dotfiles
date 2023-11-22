local cmp = require('cmp')
-- local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip',                option = { use_show_condition = false, show_autosnippets = true } },
            { name = 'calc' },
            { name = 'nvim_lsp_signature_help' },
        },
        {
            { name = 'buffer' },
        }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    view = {
        entries = {
            name = 'custom',
            selection_order = 'near_cursor',
        },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-c>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
})
