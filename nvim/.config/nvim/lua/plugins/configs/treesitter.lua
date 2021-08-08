local M = {}

M.config = function()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {"cpp","java","lua",},
    ignore_install = {"haskell"},
    matchup = {
      enable = true,
    },
    highlight = {
      enable = true,
      additional_vim_regrex_highlighting = true,
    },
    context_commentstring = {
      enable = false,
    },
    autotag = { enable = false},
    textobjects = {
      swap = {
        enable = false,
      },
      select = {
        enable = false,
      },
    },
    textsubjects = {
      enable = false,
      keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
    },
    playground = {
      enable = false,
      disable = {},
      updatetime = 25,
      persist_queries = false,
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    rainbow = {
      enable = false,
      extended_mode = true,
      max_file_lines = 1000,
    },
  }
end

return M
  
