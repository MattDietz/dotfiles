-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- require("snacks")

vim.keymap.set({ "n", "s", "v" }, "<C-p>", function()
  Snacks.dashboard.pick("files")
end)

vim.keymap.set("n", ";", ":") -- Map ; to behave like : (open command palette)
vim.keymap.set("n", ":", ";") -- Map : to behave like ; (go to last change)
vim.keymap.del({ "n", "v" }, "s") -- Unmap 's'r
vim.keymap.set("n", "<C-b>", "<leader>fe", { desc = "Call <leader>e (Snacks Explorer)" })
vim.keymap.set("n", "<C-[>", "<C-t>", { desc = "Jump back to previous" })
vim.keymap.del({ "n", "v" }, "<C-b>")
vim.keymap.set({ "n", "v" }, "<C-b>", function()
  require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
end, { desc = "Explorer NeoTree (Root Dir)" })
