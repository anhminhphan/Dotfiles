local M = {}

local null_ls = require("null-ls")
local sources = {}
local utils = require("utilities")

local local_executables = { "prettier", "prettierd", "prettier_d_slim", "eslint_d", "eslint", "clang_format"}

local find_local_exe = function(exe)
  vim.cmd "let root_dir = FindRootDirectory()"
  local root_dir = vim.api.nvim_get_var "root_dir"
  local local_exe = root_dir .. "/node_modules/.bin/" .. exe
  return local_exe
end

local function setup_ls(exe, type)
  if utils.has_value(local_executables, exe) then
    local smart_executable = null_ls.builtins[type][exe]
    local local_executable = find_local_exe(exe)
    if vim.fn.executable(local_executable) == 1 then
      smart_executable._opts.command = local_executable
      table.insert(sources, smart_executable)
    else
      if vim.fn.executable(exe) == 1 then
        table.insert(sources, smart_executable)
      end
    end
  else
    if null_ls.builtins[type][exe] and vim.fn.executable(null_ls.builtins[type][exe]._opts.command) then
      table.insert(sources, null_ls.builtins[type][exe])
    end
  end
  null_ls.register { sources = sources }
end

local function setup(filetype, type)
  local executables = nil
  if type == "diagnostics" then
    executables = language_servers[filetype].linters
  end
  if type == "formatting" then
    executables = language_servers[filetype].formatter.exe
  end

  if utils.is_table(executables) then
    for _, exe in pairs(executables) do
      if exe ~= "" then
        setup_ls(exe, type)
      end
    end
  end
  if utils.is_string(executables) and executables ~= "" then
    setup_ls(executables, type)
  end
end

function M.setup(filetype)
  setup(filetype, "formatting")
  setup(filetype, "diagnostics")
  sources = sources
  return sources
end

return M


