return {
  "christoomey/vim-tmux-navigator",
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  keys = {
    { "<M-h>", ":TmuxNavigateLeft<cr>", desc = "left", silent = true },
    { "<M-j>", ":TmuxNavigateDown<cr>", desc = "down", silent = true },
    { "<M-k>", ":TmuxNavigateUp<cr>", desc = "up", silent = true },
    { "<M-l>", ":TmuxNavigateRight<cr>", desc = "right", silent = true },
  },
}
