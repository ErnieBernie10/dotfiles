-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Safely execute immediately
now(function()
    vim.o.termguicolors = true
end)
now(function()
    require('mini.notify').setup()
    vim.notify = require('mini.notify').make_notify()
end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.pairs').setup() end)
now(function() require('mini.tabline').setup() end)
now(function()
    add({ source = 'bluz71/vim-moonfly-colors', name = "moonfly" })
    vim.cmd('colorscheme moonfly')
end)

-- Safely execute later
later(function() require('mini.ai').setup() end)
later(function() require('mini.comment').setup() end)
later(function() require('mini.pick').setup() end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.git').setup() end)

-- Use external plugins with `add()`
now(function()
    -- Add to current session (install if absent)
    add('nvim-tree/nvim-web-devicons')
    require('nvim-web-devicons').setup()
end)

now(function()
    add('echasnovski/mini.files')
    require('mini.files').setup()
end)

now(function()
    -- Supply dependencies near target plugin
    add('williamboman/mason.nvim')
    add('williamboman/mason-lspconfig.nvim')
    add({ source = 'scalameta/nvim-metals', depends = { 'nvim-lua/plenary.nvim' } })
    add({ source = 'neovim/nvim-lspconfig', depends = { 'williamboman/mason.nvim' } })
    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = false
    })
    add('MoaidHathot/dotnet.nvim')

    require('lang.lua')

    require('lang.gleam')

    require('lang.dotnet')

    require('lang.metals')

    require('lang.go')

    require('lang.elixir')
end)
later(function()
    add('echasnovski/mini.clue')
    local miniclue = require('mini.clue')
    miniclue.setup({
        triggers = {
            -- Leader triggers
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },

            -- Built-in completion
            { mode = 'i', keys = '<C-x>' },

            -- `g` key
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },

            -- Marks
            { mode = 'n', keys = "'" },
            { mode = 'n', keys = '`' },
            { mode = 'x', keys = "'" },
            { mode = 'x', keys = '`' },

            -- Registers
            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },
            { mode = 'i', keys = '<C-r>' },
            { mode = 'c', keys = '<C-r>' },

            -- Window commands
            { mode = 'n', keys = '<C-w>' },

            -- `z` key
            { mode = 'n', keys = 'z' },
            { mode = 'x', keys = 'z' },
        },

        clues = {
            -- Enhance this by adding descriptions for <Leader> mapping groups
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
        },
    })
end)

later(function()
    add('echasnovski/mini.completion')
    require('mini.completion').setup()
end)
later(function()
    add({
        source = 'nvim-treesitter/nvim-treesitter',
        -- Use 'master' while monitoring updates in 'main'
        checkout = 'master',
        monitor = 'main',
        -- Perform action after every checkout
        hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    })
    require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'vimdoc', 'c_sharp', 'scala' },
        highlight = { enable = true },
    })
end)

later(function()
    add({ source = 'nvim-telescope/telescope.nvim', depends = { 'nvim-telescope/telescope-fzf-native.nvim', 'nvim-lua/plenary.nvim' } })

    local actions = require("telescope.actions")
    local opts = {
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
    opts.pickers = {}

    for picker, _ in pairs(require("telescope.builtin")) do
        opts.pickers[picker] = { theme = "ivy" }
    end

    require("telescope").setup(opts)
end)

later(function()
    add('mistweaverco/kulala.nvim')
    require('kulala').setup({})
end)
