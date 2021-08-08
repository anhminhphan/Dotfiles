local custom_utils = {}

function custom_utils.reload_configs()
  vim.cmd "source ~/.config/nvim/lua/keybinds.lua"
  vim.cmd "source ~/.config/nvim/lua/plugins.lua"
  vim.cmd "source ~/.config/nvim/lua/settings.lua"
  vim.cmd "source ~/.config/nvim/lua/lsp/init.lua"
  vim.cmd ":PackerCompile"
  vim.cmd ":PackerInstall"
end

function custom_utils.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do 
    if client.name == name then
      return true
    end
  end
  return false
end

function custom_utils.is_table(t)
  return type(t) == "table"
end

function custom_utils.is_string(t)
  return type(t) == "string"
end

function custom_utils.has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

function custom_utils.add_keymap(mode, opts, keymaps)
  for _, keymap in ipairs(keymaps) do
    vim.api.nvim_set_keymap(mode, keymap[1], keymap[2], opts)
  end
end

function custom_utils.add_keymap_normal_mode(opts, keymaps)
  custom_utils.add_keymap("n", opts, keymaps)
end

function custom_utils.add_keymap_visual_mode(opts, keymaps)
  custom_utils.add_keymap("v", opts, keymaps)
end

function custom_utils.add_keymap_visual_block_mode(opts, keymaps)
  custom_utils.add_keymap("x", opts, keymaps)
end

function custom_utils.add_keymap_insert_mode(opts, keymaps)
  custom_utils.add_keymap("i", opts, keymaps)
end

function custom_utils.add_keymap_term_mode(opts, keymaps)
  custom_utils.add_keymap("t", opts, keymaps)
end

function custom_utils.unrequire(m)
  package.loaded[m] = nil
  _G[m] = nil
end

function custom_utils.gsub_args(args)
  if args == nil or type(args) ~= "table" then
    return args
  end
  local buffer_filepath = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
  for i = 1, #args do
    args[i] = string.gsub(args[i], "${FILEPATH}", buffer_filepath)
  end
  return args
end

function custom_utils.define_augroups(definitions)
  for group_name, definition in pairs(definitions) do 
    vim.cmd("augroup " .. group_name)
    vim.cmd("autocmd!")

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
    end

    vim.cmd "augroup END"
  end
end

custom_utils.define_augroups {
  _general_settings = {
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
    },
    {
      "BufWinEnter",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    {
      "BufWinEnter",
      "dashboard",
      "setlocal cursorline signcolumn=yes cursorcolumn number",
    },
    {
      "BufRead",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    {
      "BufNewFile",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    { "BufWritePost", "lv-config.lua", "lua require('lv-utils').reload_lv_config()" },
    -- { "VimLeavePre", "*", "set title set titleold=" },
  },
  _solidity = {
    { "BufWinEnter", ".tf", "setlocal filetype=hcl" },
    { "BufRead", "*.tf", "setlocal filetype=hcl" },
    { "BufNewFile", "*.tf", "setlocal filetype=hcl" },
  },
  -- _solidity = {
  --     {'BufWinEnter', '.sol', 'setlocal filetype=solidity'}, {'BufRead', '*.sol', 'setlocal filetype=solidity'},
  --     {'BufNewFile', '*.sol', 'setlocal filetype=solidity'}
  -- },
  -- _gemini = {
  --     {'BufWinEnter', '.gmi', 'setlocal filetype=markdown'}, {'BufRead', '*.gmi', 'setlocal filetype=markdown'},
  --     {'BufNewFile', '*.gmi', 'setlocal filetype=markdown'}
  -- },
  _markdown = {
    { "FileType", "markdown", "setlocal wrap" },
    { "FileType", "markdown", "setlocal spell" },
  },
  _buffer_bindings = {
    { "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
  },
  _auto_resize = {
    -- will cause split windows to be resized evenly if main window is resized
    { "VimResized", "*", "wincmd =" },
  },
  _packer_compile = {
    -- will cause split windows to be resized evenly if main window is resized
    { "BufWritePost", "plugins.lua", "PackerCompile" },
  },

  -- _fterm_lazygit = {
  --   -- will cause esc key to exit lazy git
  --   {"TermEnter", "*", "call LazyGitNativation()"}
  -- },
  -- _mode_switching = {
  --   -- will switch between absolute and relative line numbers depending on mode
  --   {'InsertEnter', '*', 'if &relativenumber | let g:ms_relativenumberoff = 1 | setlocal number norelativenumber | endif'},
  --   {'InsertLeave', '*', 'if exists("g:ms_relativenumberoff") | setlocal relativenumber | endif'},
  --   {'InsertEnter', '*', 'if &cursorline | let g:ms_cursorlineoff = 1 | setlocal nocursorline | endif'},
  --   {'InsertLeave', '*', 'if exists("g:ms_cursorlineoff") | setlocal cursorline | endif'},
  -- },
  _user_autocommands = {
    { "FileType", "qf", "set nobuflisted" },
  },
}

return custom_utils
