return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      popup_mappings = {
        scroll_down = "<c-n>", -- binding to scroll down inside the popup
        scroll_up = "<c-p>", -- binding to scroll up inside the popup
      },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["z"] = { name = "+fold" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>h"] = { name = "+harpoon" },
        ["<leader>o"] = { name = "+org" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
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

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():append()
      end, { desc = "Append to harpoon" })
      vim.keymap.set("n", "<leader>he", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Toggle harpoon menu" })

      vim.keymap.set("n", "<leader>h1", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon 1" })
      vim.keymap.set("n", "<leader>h2", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon 2" })
      vim.keymap.set("n", "<leader>h3", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon 3" })
      vim.keymap.set("n", "<leader>h4", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon 4" })
      vim.keymap.set("n", "<leader>h5", function()
        harpoon:list():select(5)
      end, { desc = "Harpoon 5" })

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
}
