local vscode = require('vscode')

vim.g.mapleader = " "
-- highlight on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {higroup='IncSearch', timeout=200}")

vim.o.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.relativenumber = true
vim.wo.cursorline = true
vim.wo.scrolloff = 10

-- lsp
vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", {
    desc = "Lsp Info"
})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
    desc = "Goto Definition"
})
vim.keymap.set("n", "gr", vim.lsp.buf.references, {
    desc = "References",
    nowait = true
})
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {
    desc = "Goto Implementation"
})
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, {
    desc = "Goto T[y]pe Definition"
})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
    desc = "Goto Declaration"
})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {
    desc = "Hover"
})
vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, {
    desc = "Signature Help"
})
vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, {
    desc = "Signature Help"
})
vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {
    desc = "Code Action"
})
vim.keymap.set({"n", "v"}, "<leader>cc", vim.lsp.codelens.run, {
    desc = "Run Codelens"
})
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, {
    desc = "Refresh & Display Codelens"
})
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
    desc = "Rename"
})
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, {
    desc = "Show Line Diagnostics"
})
-- vscode
-- Search files in the project
function quickOpen()
    vscode.action("workbench.action.quickOpen")
end

vim.keymap.set("n", "<leader>ff", quickOpen, {
    desc = "Quick open"
})
vim.keymap.set("n", "<leader> ", quickOpen, {
    desc = "Quick open"
})

-- open explorer
function openExplorer()
    vscode.action("workbench.view.explorer")
end
vim.keymap.set("n", "<leader>e", openExplorer, {
    desc = "Explorer"
})

function gotoLeftTab()
    vscode.action("workbench.action.previousEditor")
end
function gotoRightTab()
    vscode.action("workbench.action.nextEditor")
end
vim.keymap.set("n", "<C-h>", gotoLeftTab, {
    desc = "Previous Tab"
})
vim.keymap.set("n", "<C-l>", gotoRightTab, {
    desc = "Next Tab"
})
