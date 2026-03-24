-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.opt.relativenumber = false
vim.opt.showtabline = 1

-- Set this to "" to turn off copying to the system clipboard
-- lazyvim default is opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
-- See :help clipboard for more details
vim.opt.clipboard = ""
