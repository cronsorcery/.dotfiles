-- Install via:
-- `git clone --depth 1 https://github.com/wbthomason/packer.nvim\
-- ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
-------------------------------------------------------------------

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
    function(use)
        use('wbthomason/packer.nvim')

        -- Fuzzy search
        use({
            'nvim-telescope/telescope.nvim',
            tag = '0.1.2',
            -- branch = '0.1.x',
            requires = { { 'nvim-lua/plenary.nvim' } }
        })

        -- Colorscheme
        use({
            'rose-pine/neovim',
            as = 'rose-pine',
            config = function()
                vim.cmd('colorscheme rose-pine')
            end
        })

        -- Parser
        use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

        -- Git
        use('tpope/vim-fugitive')
        use({ 'airblade/vim-gitgutter', branch = 'main' })

        -- Comments
        use('tpope/vim-commentary')

        -- Packages
        use('williamboman/mason.nvim')

        -- Language servers
        use('williamboman/mason-lspconfig.nvim')
        use('neovim/nvim-lspconfig')

        -- Autocompletion
        use('hrsh7th/cmp-nvim-lsp')
        use('hrsh7th/nvim-cmp')
        use('hrsh7th/cmp-buffer')
        use('hrsh7th/cmp-path')
        use('hrsh7th/cmp-cmdline')
        use('hrsh7th/cmp-nvim-lua')
        use({ 'petertriho/cmp-git', requires = 'nvim-lua/plenary.nvim' })
        -- use('Jezda1337/cmp_bootstrap')
        use({ 'saadparwaiz1/cmp_luasnip', requires = 'L3MON4D3/LuaSnip' })
    end)
