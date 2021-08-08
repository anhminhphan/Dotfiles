local M = {}

M.config = function()
  require("hop").setup {
    reverse_distribution = true,
    vim.api.nvim_set_keymap('n', '<leader>w', "<cmd>lua require('hop').hint_words()<cr>", {}),
    vim.api.nvim_set_keymap('n', '<leader>/', "<cmd> lua require('hop').hint_patterns()<cr>", {}),
  }
end

return M
