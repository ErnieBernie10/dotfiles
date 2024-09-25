vim.g.mapleader = ' '

-- mini.files
vim.keymap.set('n', '<leader>e', function()
    require('mini.files').open()
end, { noremap = true, silent = true, desc = "Open mini.files" })


-- Telescope
local function project_files()
    local builtin = require('telescope.builtin')
    builtin.find_files(opts)
end
local function lsp_symbols()
    require("telescope.builtin").lsp_workspace_symbols({
        filter = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
        }
    })
end
vim.keymap.set('n', "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
vim.keymap.set('n', "<leader><space>", project_files, { desc = "Find Files" })
vim.keymap.set('n', "<leader>ff", project_files, { desc = "Find Files" })
vim.keymap.set('n', "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find Files (git-files)" })
vim.keymap.set('n', "<leader>fs", lsp_symbols, { desc = "Find Symbols" })
vim.keymap.set('n', "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })

-- lsp
vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References", nowait = true })
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })

-- buffers
vim.keymap.set("n", "H", ":bprevious<CR>", { desc = "Go to Previous Buffer" })
vim.keymap.set("n", "L", ":bnext<CR>", { desc = "Go to Next Buffer" })

-- windows
-- Navigate windows with Ctrl+h, Ctrl+j, Ctrl+k, Ctrl+l
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to the left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to the window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to the window above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to the right window' })

vim.keymap.set('n', "<F5>", "<cmd>lua require('kulala').run()<cr>", { noremap = true, silent = true })
