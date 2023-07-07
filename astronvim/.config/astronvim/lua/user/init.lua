return {
	colorscheme = "gruvbox-baby",
	plugins = {
		{
			"nvim-neo-tree/neo-tree.nvim",
			config = function(plugin, opts)
				require("neo-tree").setup({
					filesystem = {
						filtered_items = {
							visible = false,
							hide_dotfiles = false,
							hide_gitignored = false,
						},
					},
					event_handlers = {
						{
							event = "file_opened",
							handler = function(_)
								--auto close
								require("neo-tree").close_all()
							end,
						},
					},
				})
			end,
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			opts = function(_, config)
				-- config variable is the default configuration table for the setup function call
				local null_ls = require("null-ls")

				-- Check supported formatters and linters
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
				config.sources = {
					-- Set a formatter
					-- null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.eslint,
				}
				return config -- return final config table
			end,
		},
		{
			"luisiacc/gruvbox-baby",
			name = "gruvbox-baby",
			lazy = true,
			priority = 1000,
			config = function(plugin, opts)
				vim.g.gruvbox_baby_transparent_mode = true
			end,
		},
		{
			"jlcrochet/vim-razor",
			name = "vim-razor",
			lazy = false,
			priority = 1000,
		},
	},
}
