local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            format = {
                enable = true,

            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    }
}
