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

-- List of plugins
require("lazy").setup({
	spec = {
		-- Icons
		{ 'ryanoasis/vim-devicons' },
		{ 'nvim-tree/nvim-web-devicons' },

		-- LSP and autocomplete
		{ 'neovim/nvim-lspconfig' },
		{ 'williamboman/mason.nvim' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/nvim-cmp' },

		-- Other plugins
		{ 'akinsho/toggleterm.nvim' },
		{ 'nvim-telescope/telescope.nvim' },

		{ 'nvim-tree/nvim-tree.lua' },
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", 
				"MunifTanjim/nui.nvim",
				{"3rd/image.nvim", opts = {}},
			},
			lazy = false,
			opts = {},
		},
		{
			"vhyrro/luarocks.nvim",
			priority = 1000,
			config = true
		},

		-- Libraries
		{ 'nvim-lua/plenary.nvim' },
		{ 'MunifTanjim/nui.nvim' },

		-- UI and colors
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
		{ 'nvchad/volt' },
		{
			'nvimdev/dashboard-nvim',
			event = 'VimEnter',
			config = function()
				require('dashboard').setup {
					theme = 'doom'
				}
			end,
			dependencies = { {'nvim-tree/nvim-web-devicons'}}
		},
		{ "catppuccin/nvim", name = "catppuccin" }
	},
	install = { colorscheme = { "default" } },
	checker = { enabled = true },
})

-- Base46 Setup
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end

-- Basic settings
vim.opt.showmode = false
vim.opt.fillchars:append("eob: ")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.guicursor = 'n-v-c-i:block'
vim.opt.termguicolors = true
vim.cmd.colorscheme "default"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Mappings
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', '<C-q>', ':q!<CR>')
vim.keymap.set('n', '<C-s>', ':w!<CR>')
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<C-t>', ':ToggleTerm<CR>', { silent = true })
vim.keymap.set('n', '<Leader>f', ':Telescope<CR>', { silent = true })
vim.keymap.set('n', '<Leader>l', ':Lazy<CR>', { silent = true })
vim.keymap.set('n', '<Leader>m', ':Mason<CR>', { silent = true })
vim.keymap.set('n', '<Leader>t', ':lua require("nvchad.themes").open({ style = "bordered" })<CR>', { silent = true })
vim.keymap.set('n', '<M-RIGHT>', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '<M-LEFT>', ':bprevious<CR>', { silent = true })

-- Initializing plugins
require('toggleterm').setup()
require('mason').setup()
require('base46').load_all_highlights()
require('chadrc')

require('catppuccin').setup({
	flavour = "mocha",
	integrations = {
		dashboard = true
	}
});

require('dashboard').setup({
	theme = 'doom',
	config = {
		header = {
			'', '', '', '', '', '',
			' ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ',
			' ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ',
			' ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░',
			' ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ',
			' ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒',
			' ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░',
			' ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░',
			' ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░      ',
			' ░    ░  ░    ░ ░        ░   ░         ░            ',
			' ░                                                  ',
			'', '', ''
		},
		center = {
			{
				icon = '󰈞 ',
				icon_hl = 'Title',
				desc = 'Find File                ',
				desc_hl = 'String',
				key = 'f',
				keymap = '::',
				key_hl = 'Number',
				key_format = ' %s',
				action = ':Neotree position=float'
			},
			{
				icon = '󰝒 ',
				icon_hl = 'Title',
				desc = 'New File                 ',
				desc_hl = 'String',
				key = 'n',
				keymap = '::',
				key_hl = 'Number',
				key_format = ' %s',
				action = ':enew'
			},
			{
				icon = ' ',
				icon_hl = 'Title',
				desc = 'Git Commits              ',
				desc_hl = 'String',
				key = 'g',
				keymap = '::',
				key_hl = 'Number',
				key_format = ' %s',
				action = ':Telescope git_commits'
			},
			{
				icon = '󱎸 ',
				icon_hl = 'Title',
				desc = 'Find Text                ',
				desc_hl = 'String',
				key = 't',
				keymap = '::',
				key_hl = 'Number',
				key_format = ' %s',
				action = ':Telescope live_grep'
			},
			{
				icon = ' ',
				icon_hl = 'Title',
				desc = 'Config                   ',
				desc_hl = 'String',
				key = 'c',
				keymap = '::',
				key_hl = 'Number',
				key_format = ' %s',
				action = ':e ~/.config/nvim/init.lua'
			},
			{
				icon = '󰒲 ',
				icon_hl = 'Title',
				desc = 'Lazy                     ',
				desc_hl = 'String',
				key = 'l',
				keymap = '::',
				key_hl = 'Number',
				key_format = ' %s',
				action = ':Lazy'
			},
			{
				icon = ' ',
				icon_hl = 'Title',
				desc = 'Quit                     ',
				desc_hl = 'String',
				key = 'q',
				keymap = '::',
				key_hl = 'Number',
				key_format = ' %s',
				action = ':qa!'
			},
		}
	}
})

require('nvim-tree').setup({
    filters = {
        dotfiles = true
    }
})

local cmp = require('cmp')
local options = {
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }
    }, {
        { name = 'buffer' }
    })
}
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
options = vim.tbl_deep_extend("force", options, require "nvchad.cmp")
require("cmp").setup(options)

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').clangd.setup { capabilities = capabilities }
require('lspconfig').pyright.setup { capabilities = capabilities }
