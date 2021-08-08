local M = {}

M.config = function()
  require("telescope").setup {
    defaults = {
      vimgrep_arguements = {
        "rg",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = " ",
      selection_caret = " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.75,
        prompt_position = "bottom",
        preview_cutoff = 120,
        horizontal = { mirror = false },
        vertical = { mirror = false },
      },
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      file_ignore_patterns = {},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "shorten" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },

    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      media_files = {
        filetypes = {"png", "webp", "jpg", "jpeg"},
        find_cmd = "rg",
      }
    },
  }

  -- enable extensions
  require("telescope").load_extension("fzy_native")
  require("telescope").load_extension("media_files")
  require("telescope").load_extension("frecency")

  -- keybinds
  vim.api.nvim_set_keymap("n", "<Leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<Leader>g", ":Telescope live_grep<CR>", { noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<Leader>F", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", { noremap = true, silent = true})

end
return M

