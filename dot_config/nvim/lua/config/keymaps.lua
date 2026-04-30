-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("v", "<leader>yl", function()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local file = vim.fn.expand("%")
  local text = string.format("@%s\nL%d-L%d", file, start_line, end_line)

  vim.fn.setreg("+", text)

  vim.notify("Copied file range: " .. text)
end, { desc = "Copy file range" })
