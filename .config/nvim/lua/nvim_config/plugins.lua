-- Install via:
-- `git clone --depth 1 https://github.com/wbthomason/packer.nvim\
-- ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
-------------------------------------------------------------------

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require('packer').startup(
    function(use)
        use('wbthomason/packer.nvim')

        -- Fuzzy search
        use({
            'nvim-telescope/telescope.nvim',
            tag = '0.1.4',
            -- branch = '0.1.x',
            requires = {
                { 'nvim-lua/plenary.nvim' },
                { 'BurntSushi/ripgrep',          opt = true },
                { 'nvim-tree/nvim-web-devicons', opt = true },
            }
        })

        -- Colorscheme
        use({
            'rose-pine/neovim',
            as = 'rose-pine',
            config = function()
                vim.cmd('colorscheme rose-pine')
            end
        })

        use({
            'nvim-lualine/lualine.nvim',
            requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        })

        -- Parser
        use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

        -- Git
        use('tpope/vim-fugitive')
        use({ 'airblade/vim-gitgutter', branch = 'main' })

        -- Comments
        use('tpope/vim-commentary')

        -- Language servers
        use('neovim/nvim-lspconfig')

        -- Packages
        use('williamboman/mason.nvim')
        use('williamboman/mason-lspconfig.nvim')

        -- Completion
        use('hrsh7th/nvim-cmp')
        -- nvim-cmp sources
        use('hrsh7th/cmp-nvim-lsp')                -- lsp completions
        use('hrsh7th/cmp-buffer')                  -- buffer words
        use('hrsh7th/cmp-path')                    -- paths
        use('L3MON4D3/LuaSnip')                    -- snippet engine
        use('hrsh7th/cmp-calc')                    -- calculator
        use('hrsh7th/cmp-nvim-lsp-signature-help') -- function signatures
        use('hrsh7th/cmp-nvim-lua')                -- qol ricing
    end)
