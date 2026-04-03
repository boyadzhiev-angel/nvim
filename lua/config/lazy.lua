-- Bootstrap lazy.nvim
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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
        {
            'nvim-telescope/telescope.nvim', tag = '*',
            dependencies = {
                'nvim-lua/plenary.nvim',
                -- optional but recommended
                { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' },
            {
                'nvim-treesitter/nvim-treesitter',
                lazy = false,
                build = ':TSUpdate'
            },
            {
                "ThePrimeagen/harpoon",
                branch = "harpoon2",
                dependencies = { "nvim-lua/plenary.nvim" }
            },
            {'mbbill/undotree'},
            {'tpope/vim-fugitive', url= "https://github.com/tpope/vim-fugitive"},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-vsnip'},
            {'hrsh7th/vim-vsnip'},
            {'github/copilot.vim'},
--            {  "nvim-tree/nvim-tree.lua",
--            version = "*",
--            lazy = false,
--            dependencies = {
--                "nvim-tree/nvim-web-devicons",
--            },
--           config = function()
--                require("nvim-tree").setup({
--                    sort = {
--                        sorter = "case_sensitive",
--                    },
--                    view = {
--                        width = 30,
--                    },
--                    renderer = {
--                        group_empty = true,
--                    },
--                    filters = {
--                        dotfiles = true,
--                    },
--                })
--            end},
        }
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
