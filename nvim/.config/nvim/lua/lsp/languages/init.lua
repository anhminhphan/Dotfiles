local common_on_attach = require("lsp").common_on_attach
local common_capabilities = requrie("lsp").common_capabilities()

language_servers = {
  c = {
    formatter = {
      exe = "clang_format",
      args = {},
      stdin = true,
    },
    linters = {
      "clangtidy",
    },
    lsp = {
      provider = "clangd",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/cpp/clangd/vin/clangd",
          "--background-index",
          "--header-insertion = never",
          "--cross-file-rename",
          "--clang-tidy",
          "--clang-tidy-checks=-*,clang-analyzer-*",
        },
        on_attach = common_on_attach,
        capabilities = common_capabilities,
      },
    },
  },

  cpp = {
    formatter = {
      exe = "clang_format",
      args = {},
      stdin = true,
    },
    linters = {
      "cppcheck",
      "clangtidy",
    },
    lsp = {
      provider = "clangd",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd",
          "--background-index",
          "--header-insertion = never",
          "--cross-file-rename",
          "--clang-tidy",
          "--clang-tidy-checks=-*,clang-analyzer-*",
        },
        on_attach = common_on_attach,
        capabilities = common_capabilities,
      },
    },
  },

  java = {
    formatter = {
      exe = "prettier",
      args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    },
    linters = {},
    lsp = {
      provider = "jdtls",
      setup = {
        cmd = { DATA_PATH .. "/lspinstall/java/jdtls.sh" },
        on_attach = common_on_attach,
        capabilities = common_capabilities,
      },
    },
  },

  lua = {
    formatter = {
      exe = "stylua",
      args = {},
    },
    linters = { "luacheck" },
    lsp = {
      provider = "sumneko_lua",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/lua/sumneko-lua-language-server",
          "-E",
          DATA_PATH .. "/lspinstall/lua/main.lua",
        },
        on_attach = common_on_attach,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJUT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = {"vim","nvim"},
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 1000,
            },
          },
        },
      },
    },
  },

}




