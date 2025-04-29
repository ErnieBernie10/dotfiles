return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local actions = require('telescope.actions')

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
                file_ignore_patterns = {
                    "node_modules"
                },

                mappings = {
                    n = { q = actions.close },
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,                       -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,                           -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                    }
                },
            },
        }
        opts.pickers = {}

        for picker, _ in pairs(require("telescope.builtin")) do
            opts.pickers[picker] = { theme = "ivy" }
        end

        require("telescope").setup(opts)

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
        vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })

        -- Rip grep + Fzf
        vim.keymap.set('n', '<leader>fg', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)

        -- Find instance instance of current view being included
        vim.keymap.set('n', '<leader>fc', function()
            local filename_without_extension = vim.fn.expand('%:t:r')
            builtin.grep_string({ search = filename_without_extension })
        end, { desc = "Find current file: " })

        -- Grep current string (for when gd doesn't work)
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({})
        end, { desc = "Find current string: " })

        -- find files in vim config
        vim.keymap.set('n', '<leader>fi', function()
            builtin.find_files({ cwd = "~/.config/nvim/" });
        end)
    end
}
