local lspconfig = require('lspconfig')

if vim.fn.executable('dotnet') == 1 then
    -- lspconfig.omnisharp.setup({
    --     settings = {
    --         FormattingOptions = {
    --             EnableEditorConfigSupport = true
    --         }
    --     }
    -- })
    require('roslyn').setup {
        args = {
            '--logLevel=Information',
            '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
            '--razorSourceGenerator=' .. vim.fs.joinpath(
                vim.fn.stdpath 'data' --[[@as string]],
                'mason',
                'packages',
                'roslyn',
                'libexec',
                'Microsoft.CodeAnalysis.Razor.Compiler.dll'
            ),
            '--razorDesignTimePath=' .. vim.fs.joinpath(
                vim.fn.stdpath 'data' --[[@as string]],
                'mason',
                'packages',
                'rzls',
                'libexec',
                'Targets',
                'Microsoft.NET.Sdk.Razor.DesignTime.targets'
            ),
        },
        config = {
            on_attach = function() end,
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            handlers = require 'rzls.roslyn_handlers',
        },
    }

    require("dotnet").setup({})
end
