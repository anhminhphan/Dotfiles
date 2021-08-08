local M = {}

function define_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd("autocmd!")

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten {"autocmd", def }, " ")
      vim.cmd(command)
    end

    vim.cmd "augroup END"
  end
end

M.config= function()
  local status_ok, linter = pcall(require, "lint")
  if not status_ok then
    return
  end

  define_augroups {
    autolint = {
      {
        "BufWritePost",
        "<buffer>",
        ":silent lua require('lint').try_lint()",
      },
      {
        "BufEnter",
        "<buffer>",
        ":silent lua require('lint').try_lint()",
      },
    }
  }
end


return M

