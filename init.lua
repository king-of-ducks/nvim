-- Initializing Lazy.nvim
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
		{ 'catppuccin/nvim' },
		{ 'ryanoasis/vim-devicons' },
		{ 'nvim-tree/nvim-web-devicons' },
		{ 'neovim/nvim-lspconfig' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/nvim-cmp' },
		{ 'akinsho/bufferline.nvim' },
		{ 'nvim-neo-tree/neo-tree.nvim' },
		{ 'akinsho/toggleterm.nvim' },
		{ 'nvimdev/dashboard-nvim' },
		{ 'nvim-telescope/telescope.nvim' },
		{ 'nvim-lua/plenary.nvim' },
		{ 'MunifTanjim/nui.nvim' }
	},
	install = { colorscheme = { "catppuccin-mocha" } },
	checker = { enabled = true },
})

-- Basic settings
vim.opt.showmode = false
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.guicursor = 'n-v-c-i:block'
vim.opt.termguicolors = true
vim.cmd('colorscheme catppuccin-mocha')
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Mappings
vim.keymap.set('n', '/', ':')
vim.keymap.set('n', '<C-q>', ':q!<CR>')
vim.keymap.set('n', '<C-s>', ':w!<CR>')
vim.keymap.set('n', '<C-n>', ':Neotree right toggle<CR>')
vim.keymap.set('n', '<C-t>', ':ToggleTerm<CR>')
vim.keymap.set('n', '<M-i>', ':BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<M-o>', ':BufferLineCycleNext<CR>')

-- Initializing plugins
require('bufferline').setup()
require('toggleterm').setup()

function default_header()
	return {
		'', '', '',
		' ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓',
		' ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒',
		'▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░',
		'▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ',
		'▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒',
		'░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░',
		'░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░',
		'   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ',
		'         ░    ░  ░    ░ ░        ░   ░         ░   ',
		'                        ░                          ',
		'', '', '', ''
	}
end

local mode_map = {
	['n']    = ' NORMAL',
	['no']   = ' O-PENDING',
	['nov']  = ' O-PENDING',
	['noV']  = ' O-PENDING',
	['no�']  = ' O-PENDING',
	['niI']  = ' NORMAL',
	['niR']  = ' NORMAL',
	['niV']  = ' NORMAL',
	['nt']   = ' NORMAL',
	['v']    = ' VISUAL',
	['vs']   = ' VISUAL',
	['V']    = ' VISUAL-LINE',
	['Vs']   = ' VISUAL-LINE',
	['�']    = ' VISUAL-BLOCK',
	['�s']   = ' VISUAL-BLOCK',
	['s']    = ' SELECT',
	['S']    = ' SELECT-LINE',
	['�']    = ' SELECT-BLOCK',
	['i']    = ' INSERT',
	['ic']   = ' INSERT',
	['ix']   = ' INSERT',
	['R']    = ' REPLACE',
	['Rc']   = ' REPLACE',
	['Rx']   = ' REPLACE',
	['Rv']   = ' V-REPLACE',
	['Rvc']  = ' V-REPLACE',
	['Rvx']  = ' V-REPLACE',
	['c']    = ' COMMAND',
	['cv']   = ' EX',
	['ce']   = ' EX',
	['r']    = ' REPLACE',
	['rm']   = ' MORE',
	['r?']   = ' CONFIRM',
	['!']    = ' SHELL',
	['t']    = ' TERMINAL',
}

require('dashboard').setup({
	theme = 'doom',
	config = {
		header = default_header(),
		center = {
			{
				icon = '󱇧 ',
				icon_hl = 'Title',
				desc = 'Open file',
				desc_hl = 'String',
				key = 'o',
				keymap = 'SPC f o',
				key_hl = 'Number',
				action = ':Neotree float'
			},
			{
				icon = ' ',
				icon_hl = 'Title',
				desc = 'Open terminal',
				desc_hl = 'String',
				key = 'c',
				keymap = 'SPC f c',
				key_hl = 'Number',
				action = ':ToggleTerm direction=float'
			},
			{
				icon = '󰈞 ',
				icon_hl = 'Title',
				desc = 'Find file',
				desc_hl = 'String',
				key = 'f',
				keymap = 'SPC f f',
				key_hl = 'Number',
				action = ':Telescope find_files'
			},
			{
				icon = '󱋡 ',
				icon_hl = 'Title',
				desc = 'View Recent Files      ',
				desc_hl = 'String',
				key = 'r',
				keymap = 'SPC f r',
				key_hl = 'Number',
				action = ':Telescope oldfiles'
			},
			{
				icon = ' ',
				icon_hl = 'Title',
				desc = 'Open Config file',
				desc_hl = 'String',
				key = 's',
				keymap = 'SPC f s',
				key_hl = 'Number',
				action = ':e /data/data/com.termux/files/home/.config/nvim/init.lua'
			}
		}
	}
})

require('catppuccin').setup({
	integrations = {
		dashboard = true
	},
	no_italic = true
})

require('lualine').setup({
	options = {
		theme = "catppuccin",
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' }
	},
	sections = {
		lualine_a = {
			function ()
				return mode_map[vim.api.nvim_get_mode().mode]
			end
		},
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
