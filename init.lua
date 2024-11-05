-- Initializing Lazy.nvim
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {	
        { 'nvim-lualine/lualine.nvim' },
        { 'ryanoasis/vim-devicons' },
        { 'nvim-tree/nvim-web-devicons' },
        { 'neovim/nvim-lspconfig' },
        { 'nvim-tree/nvim-tree.lua' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/nvim-cmp' },
        { 'akinsho/toggleterm.nvim' },
        { 'nvim-telescope/telescope.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'MunifTanjim/nui.nvim' },
        { 'williamboman/mason.nvim' },
        {
            "nvchad/ui",
            config = function()
                require "nvchad" 
            end
        },
        {
            "nvchad/base46",
            lazy = false,
            build = function()
                require("base46").load_all_highlights()
            end,
        },
        { 'nvchad/volt' }
    },
    install = { colorscheme = { "nvchad" } },
    checker = { enabled = true },
})
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
end

-- Basic settings
vim.opt.showmode = false
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.guicursor = 'n-v-c-i:block'
vim.opt.termguicolors = true
vim.cmd.colorscheme "default"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Mappings
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', '<C-q>', ':q!<CR>')
vim.keymap.set('n', '<C-s>', ':w!<CR>')
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<C-t>', ':ToggleTerm<CR>', { silent = true })

-- Initializing plugins
require('toggleterm').setup()
require('mason').setup()
require('base46').load_all_highlights()
require('chadrc')

require('nvim-tree').setup({
    filters = {
        dotfiles = true
    }
})

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body) 
        end,
    },
    window = {
        completion = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<PGDN>'] = cmp.mapping.scroll_docs(-4),
        ['<PGUP>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
    })
})
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['clangd'].setup { capabilities = capabilities }
