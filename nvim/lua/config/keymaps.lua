-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<leader>sp", "<cmd>FzfLua live_grep <cr>", { desc = "Lazygit (cwd)" })
map("n", "<leader>h", "<C-W>h", { desc = "Goto left window" })
map("n", "<leader>l", "<C-W>l", { desc = "Goto right window" })
map("n", "<leader>j", "<C-W>j", { desc = "Goto lower window" })
map("n", "<leader>k", "<C-W>k", { desc = "Goto upper window" })
