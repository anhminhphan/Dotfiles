local M = {}

M.config = function()
  local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
  if not status_ok then
    return
  end

  local g = vim.g

  vim.o.termguicolors = true
  g.nvim_tree_side = "left"
  g.nvim_tree_width = 25 
  g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
  g.nvim_tree_auto_open = 1
  g.nvim_tree_auto_close = 1
  g.nvim_tree_quit_on_open = 0 g.nvim_tree_follow = 1
  g.nvim_tree_indent_markers = 1
  g.nvim_tree_hide_dotfiles = 1
  g.nvim_tree_git_hl = 1
  g.nvim_tree_root_folder_modifier = ":t"
  g.nvim_tree_tab_open = 0
  g.nvim_tree_allow_resize = 1
  g.nvim_tree_lsp_diagnostics = 1
  g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }

  g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
  }

  vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
      unstaged = "",
      staged = "S",
      unmerged = "",
      renamed = "➜",
      deleted = "",
      untracked = "U",
      ignored = "◌",
    },
    folder = {
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
    },
  }
  local tree_cb = nvim_tree_config.nvim_tree_callback

  vim.g.nvim_tree_bindings = {
    { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
    { key = "<ESC>", cb = tree_cb "close_node" },
    { key = "h", cb = tree_cb "split" },
    { key = "v", cb = tree_cb "vsplit" },
    { key = "r", cb = tree_cb "full_rename"},
    { key = "c", cb = tree_cb "copy"},
    { key = "x", cb = tree_cb "cut"},
    { key = "p", cb = tree_cb "paste"},
    { key = "a", cb = tree_cb "create"},
    { key = "dd", cb = tree_cb "remove"},
    { key = "<ESC><ESC>", cb = tree_cb "close"},
    { key = ".", cb = tree_cb "toggle_dotfiles"},
  }

local view_status_ok, view = pcall(require, "nvim-tree.view")
if not view_status_ok then
  return
end

M.toggle_tree = function()
  if view.win_open() then
    require("nvim-tree").close()
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(0)
    end
  else
    if package.loaded["bufferline.state"] then
      -- require'bufferline.state'.set_offset(31, 'File Explorer')
      require("bufferline.state").set_offset(31, "")
    end
    require("nvim-tree").find_file(true)
  end
end

-- keybinds
vim.api.nvim_set_keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

end

return M
