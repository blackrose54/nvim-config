require "nvchad.mappings"
require "nvchad.lsp.renamer"
-- add yours here
--
function Rename()
  vim.ui.input({
    prompt="Rename"
  },function (input)
      vim.lsp.buf.rename(input)
  end)
end

local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("n","<leader>ra",Rename)
map("n","<leader>ca",vim.lsp.buf.code_action)
map("n","gd",vim.lsp.buf.definition)
map("n","gi",vim.lsp.buf.implementation)
map("n","gr",vim.lsp.buf.references)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
