return {
  {
    "akinsho/org-bullets.nvim",
    config = function()
      require("org-bullets").setup()
    end,
  },
  {
    "nvim-orgmode/orgmode",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", lazy = true },
    },
    event = "VeryLazy",
    config = function()
      -- Load treesitter grammar for org
      require("orgmode").setup_ts_grammar()

      -- Setup treesitter
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        ensure_installed = { "org" },
      })

      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/Personal/org/**/*",
        org_default_notes_file = "~/Personal/org/refile.org",
        org_capture_templates = {
          j = {
            description = "Journal",
            template = "\n*** %<%A> %<%d-%m-%Y>\n**** %<%H:%M>\n%?",
            target = "~/Personal/org/journal/%<%Y-%m>.org",
          },
        },
      })
    end,
  },
}
