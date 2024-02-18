-- gloggers' neovim configuration
--
-- https://github.com/gloggers99
-- https://gloggers.net

-- Automatically install lazy.nvim if its not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
    -- QOL
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

    -- Utilities (windows and such)
    { "folke/which-key.nvim", opts = {} },
    { "nvim-tree/nvim-tree.lua", lazy = false, opts = {} },
    { "nvim-tree/nvim-web-devicons" },
    { "akinsho/toggleterm.nvim", version = "*", config = true},
    { "stevearc/aerial.nvim", opts = { layout = { min_width = 30 } }, dependencies = { "nvim-treesitter/nvim-treesitter" } },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- LSP plugins
    { "j-hui/fidget.nvim", opts = {}, }, -- doesn't seem to work with mason-installed servers
    { "williamboman/mason.nvim", opts = {} },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {},
        config = function()
            require("mason-lspconfig").setup_handlers {
                function (server_name)
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end
            }
        end
    },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },

    -- Pretty plugins
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "nvchad/nvim-colorizer.lua", opts = {} },
    { "pseewald/vim-anyfold" },
    { "anuvyklack/pretty-fold.nvim", opts = {} },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }
})

local cmp = require("cmp")

-- Autocomplete general configuration
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    confirmation = {
        completeopt = "menu,menuone"
    },
    window = {
        completion = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = true })
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
    },  {
        { name = "buffer" },
    })
})

-- Autocomplete for git
cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "git" },
    }, {
        { name = "buffer" },
    })
})

-- Autocomplete for searching
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

-- Autocomplete for vim commands
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
})

-- General vim configuration using vimscript because lua is hot garbage
vim.cmd("source ~/.config/nvim/config.vim")
