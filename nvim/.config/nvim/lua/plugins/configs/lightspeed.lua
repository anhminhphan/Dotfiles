local M = {}

M.config = function()
  require("lightspeed").setup {
    jump_to_first_match = true,
    jump_on_partial_input_safety_timeout = 400,
    highlight_unique_chars = false,
    grey_out_search_area = true,
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 5,
    full_inclusive_prefix_key = '<c-x>',
    labels = nil,
    cycle_groud_fwd_key = nil,
    cycle_group_bwd_key = nil,
  }

  vim.api.nvim_set_keymap('n', 's', "<Plug>Lightspeed_s", {})
  vim.api.nvim_set_keymap('n', 'S', "<Plug>Lightspeed_S", {})
  vim.api.nvim_set_keymap('n', 'f', "<Plug>Lightspeed_f", {})
  vim.api.nvim_set_keymap('n', 'F', "<Plug>Lightspeed_F", {})

end




return M

