vim.cmd([[
set clipboard=unnamedplus
set number
set relativenumber
set cursorline
set noshowmode
]])

local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('catppuccin/nvim', { as = 'catppuccin' })
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'cohama/lexima.vim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'puremourning/vimspector'
Plug 'voldikss/vim-floaterm'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.5' })
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'itchyny/lightline.vim'
Plug 'RRethy/vim-illuminate'
vim.call('plug#end')

require('ibl').setup()

require('telescope').setup()

require('mason').setup()
require('mason-lspconfig').setup()

require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.opt.completeopt = {'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})



require('rust-tools').setup()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require('nvim-tree').setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
})

require('catppuccin').setup({
	flavour = "mocha",
	background = {
		light = "latte",
		dark = "mocha",
	},
	transparent_background = true,
	show_end_of_buffer = false,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
})

vim.cmd.colorscheme 'catppuccin'
vim.g.lightline = {
	colorscheme = "catppuccin"
}

function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
	map('n', shortcut, command)
end

function tmap(shortcut, command)
	map('t', shortcut, command)
end

nmap('<C-S>', '<Cmd>w<CR>')
nmap('<C-S-Up>', '<Cmd>m -2<CR>')
nmap('<C-S-Down>', '<Cmd>m +1<CR>')
nmap('<C-W>a', '<C-W><Left>')
nmap('<C-W>o', '<C-W><Down>')
nmap('<C-W>e', '<C-W><Right>')
nmap('<C-W>,', '<C-W><Up>')
nmap('<A-Left>', '<C-W><Left>')
nmap('<A-Right>', '<C-W><Right>')
nmap('<A-Up>', '<C-W><Up>')
nmap('<A-Down>', '<C-W><Down>')

nmap('<C-P>', '<Cmd>Telescope find_files theme=dropdown<CR>')

nmap('<C-F><C-T>', '<Cmd>FloatermNew --name=float --autoclose=2 zsh <CR>')
nmap('t', '<Cmd>FloatermToggle float<CR>')
tmap('<Esc>', "<C-\\><C-n>:q<CR>")

nmap('<C-N>', '<Cmd>NvimTreeToggle<CR>')

nmap('<F9>', '<Cmd>call vimspector#Launch()<CR>')
nmap('<F5>', '<Cmd>call vimspector#StepOver()<CR>')
nmap('<F8>', '<Cmd>call vimspector#Reset()<CR>')
nmap('<F11>', '<Cmd>call vimspector#StepOver()<CR>')
nmap('<F12>', '<Cmd>call vimspector#StepOut()<CR>')
nmap('<F10>', '<Cmd>call vimspector#StepInto()<CR>')

vim.cmd([[
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
]])

vim.cmd([[
:NvimTreeToggle
]])
