return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
      },
      sections = {
        lualine_b = { "branch", "harpoon2" },
      },
    },
    -- config = function()
    --   require("lualine").setup({
    --     options = {
    --       theme = "tokyonight",
    --     },
    --     sections = {
    --       lualine_a = { "mode" },
    --       lualine_b = { "branch" },
    --       lualine_c = { "filename", "harpoon2" },
    --       lualine_x = { "encoding", "fileformat", "filetype" },
    --       lualine_y = { "progress" },
    --       lualine_z = { "location" },
    --     },
    --     inactive_sections = {
    --       lualine_a = {},
    --       lualine_b = {},
    --       lualine_c = { "filename" },
    --       lualine_x = { "location" },
    --       lualine_y = {},
    --       lualine_z = {},
    --     },
    --     tabline = {},
    --     extensions = { "fugitive", "nvim-tree", "quickfix", "harpoon2" },
    --   })
    -- end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():append()
      end, { desc = "Append to harpoon" })
      vim.keymap.set("n", "<M-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<M-1>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<M-2>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<M-3>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<M-4>", function()
        harpoon:list():select(4)
      end)
      vim.keymap.set("n", "<M-5>", function()
        harpoon:list():select(5)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<M-p>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<M-n>", function()
        harpoon:list():next()
      end)
    end,
  },
  {
    "letieu/harpoon-lualine",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      },
    },
  },
  { "honza/vim-snippets", dependencies = {
    "SirVer/ultisnips",
  } },
  {
    "SirVer/ultisnips",
  },
}
