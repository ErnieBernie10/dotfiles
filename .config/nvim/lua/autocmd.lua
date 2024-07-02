-- Define the formatting function
local function lsp_formatting(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    vim.lsp.buf.format({ bufnr = bufnr })
end

-- Set up the autocommand for autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.cs", "*.lua", "*.ts", "*.js" }, -- Apply to all files or specify a filetype like "*.lua"
    callback = function()
        lsp_formatting()
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.fs", "*.fsx", "*.fsi" },
    callback = function()
        vim.bo.filetype = "fsharp"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.axaml" },
    callback = function()
        vim.bo.filetype = "xml"
    end,
})

local make = vim.fn.stdpath('config') .. '/make.vim'

-- Load and execute the Vimscript file
vim.cmd('source ' .. make)
