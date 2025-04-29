return {
    -- {
    --     "folke/tokyonight.nvim",
    --     config = function()
    --         vim.cmd.colorscheme "tokyonight"
    --         vim.cmd('hi Directory guibg=NONE')
    --         vim.cmd('hi SignColumn guibg=NONE')
    --         enable_transparency()
    --     end
    -- },
    --{
    --    "Mofiqul/vscode.nvim",
    --    name = 'vscode',
    --    config = function()
    --        vim.cmd.colorscheme "vscode"
    --        vim.cmd('hi Directory guibg=NONE')
    --        vim.cmd('hi SignColumn guibg=NONE')
    --        enable_transparency()
    --    end
    --}
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "moonfly"
        end
    },
}
