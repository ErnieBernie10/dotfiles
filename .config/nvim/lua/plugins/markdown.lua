return {
  {
    "ixru/nvim-markdown",
    config = function()
      vim.g.vim_markdown_fenced_languages = { "sql", "csahrp=cs" }
    end,
  },
  {
    "renerocksai/calendar-vim",
  },
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telekasten").setup({
        home = vim.fn.expand("~/Personal/notes/it"),
        vaults = {
          it = {
            home = vim.fn.expand("~/Personal/notes/it"),
          },
          history = {
            home = vim.fn.expand("~/Personal/notes/history"),
          },
        },
      })
    end,
  },
}
