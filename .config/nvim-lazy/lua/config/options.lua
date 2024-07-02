-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.cmdheight = 0
opt.laststatus = 1

vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25
vim.o.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.o.expandtab = true -- Use spaces instead of tabs
