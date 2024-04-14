return {
  {
    "sainnhe/gruvbox-material",
    dependencies = {
      "lualine/lualine.nvim",
    },
    config = function()
      vim.g.gruvbox_material_background = "hard"
      require("lualine").setup({
        options = {
          theme = "gruvbox-material",
        },
      })
    end,
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox-material" } },
}
