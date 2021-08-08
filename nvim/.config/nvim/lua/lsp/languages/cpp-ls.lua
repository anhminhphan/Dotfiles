local M = {}

M.config = function()
  local clang = {
    diagnostics = {
      virtual_text = false,
      signs = true,
      underline = true,
    },
    cross_file_rename = true,
    header_insertion = "never",
    filetypes = {"c","cpp","objc"},
    linters = {
      "cppcheck",
      "clangtidy",
    },
  }
end

M.lint = function()
  require("lint").linters_by_ft = {
    c = {"cppcheck","clangtidy"},
    cpp ={"cppcheck","clangtidy"},
  }
end

M.lsp = function()
  if require("utilities").check_lsp_client_active "clangd" then
    return
  end
  local clangd_flags = { "--background-index" }

  table.insert(clangd_flags, "--cross-file-rename")

  table.insert(clangd_flags, "--header-insertion=" .. "never")

  require("lspconfig").clangd.setup {
    on_attach = require("lsp").common_on_attach,
    cmd = { DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd", unpack(clangd_flags) },
    filetypes = {"c", "cpp", "objc", "objcpp"},
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = true,
      }),
    },
  }
end

return M

