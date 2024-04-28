return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd", "rust_analyzer", "tsserver" },
				auto_install = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),

				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local builtin = require("telescope.builtin")

					map("gd", builtin.lsp_definitions, "Goto Definition")
					map("gr", builtin.lsp_references, "Goto References")
					map("gi", builtin.lsp_implementations, "Goto Implementation")
					map("go", builtin.lsp_type_definitions, "Type Definition")
					map("<leader>p", builtin.lsp_document_symbols, "Document Symbols")
					-- map("<leader>P", builtin.lsp_workspace_symbols, "Workspace Symbols")
					-- map("<leader>Ps", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")

					map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
					map("gD", vim.lsp.buf.declaration, "Goto Declaration")

					map(
						"<leader>v",
						"<cmd>vsplit | lua vim.lsp.buf.definition()<cr>",
						"Goto Definition in Vertical Split"
					)

					map("<leader>ca", vim.lsp.buf.code_action, "Code Actions")
				end,
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup_handlers({
				function(server)
					lspconfig[server].setup({
						capabilities = capabilities,
					})
				end,
			})
		end,
	},
}
