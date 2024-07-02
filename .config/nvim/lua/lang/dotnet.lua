local lspconfig = require('lspconfig')

if vim.fn.executable('dotnet') == 1 then
    lspconfig.lemminx.setup({})
    lspconfig.omnisharp.setup({})

    lspconfig.fsautocomplete.setup({})
end
