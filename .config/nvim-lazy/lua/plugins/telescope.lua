return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
  },
  cmd = "Telescope",
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        git_worktrees = vim.g.git_worktrees,
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          n = { q = actions.close },
        },
      },
    }
  end,
  config = function(_, opts)
    opts.pickers = {}

    for picker, _ in pairs(require("telescope.builtin")) do
      opts.pickers[picker] = { theme = "ivy" }
    end

    require("telescope").setup(opts)
  end,
}
