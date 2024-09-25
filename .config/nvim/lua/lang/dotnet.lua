local lspconfig = require('lspconfig')

if vim.fn.executable('dotnet') == 1 then
    lspconfig.omnisharp.setup({})

    lspconfig.fsautocomplete.setup({})

    require("dotnet").setup({})
end
