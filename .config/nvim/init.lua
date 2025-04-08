vim.g.mapleader = ' '

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

MiniDeps.add({
  source = 'nvim-telescope/telescope.nvim',
  depends = {
    { source = 'nvim-lua/plenary.nvim' }
  }
})

local telescope = require('telescope.builtin')

-- Replace with your actual notes dir
local notes_dir = vim.fn.expand('~/Documents/Notes')

-- 🔍 Full-text search in notes
vim.keymap.set('n', '<leader>sn', function()
  telescope.live_grep({
    cwd = notes_dir,
    prompt_title = "Search Notes",
    search_dirs = { notes_dir },
    hidden = true, -- include hidden files if needed
  })
end, { desc = "Live grep in notes" })

-- 📂 Fuzzy file finder in notes
vim.keymap.set('n', '<leader>fn', function()
  telescope.find_files({
    cwd = notes_dir,
    prompt_title = "Find Note",
    hidden = true,
  })
end, { desc = "Find note file" })


local function open_daily_note()
  local date = os.date("%Y-%m-%d")
  local filename = notes_dir .. "/Journal/" .. date .. ".md"

  -- Create directory if it doesn't exist
  if vim.fn.isdirectory(notes_dir) == 0 then
    vim.fn.mkdir(notes_dir, "p")
  end

  if vim.fn.filereadable(filename) == 0 then
    vim.cmd("edit " .. filename)
    vim.api.nvim_buf_set_lines(0, 0, 0, false, {
    "# " .. date,
    "",
    "- [ ] ",
    "",
    })
  else
    vim.cmd("edit " .. filename)
end
end

-- 🔑 Map to <leader>dn
vim.keymap.set('n', '<leader>dn', open_daily_note, { desc = "Open daily note" })


