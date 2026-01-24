local function lsp_on_attach(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

	if nixCats('general') then
		nmap('gr', function() require('telescope.builtin').lsp_references() end, '[G]oto [R]eferences')
		nmap('gI', function() require('telescope.builtin').lsp_implementations() end, '[G]oto [I]mplementation')
		nmap('<leader>ds', function() require('telescope.builtin').lsp_document_symbols() end, '[D]ocument [S]ymbols')
		nmap('<leader>ws', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
			'[W]orkspace [S]ymbols')
	end

	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

require('lze').register_handlers(require('lzextras').lsp)
require('lze').h.lsp.set_ft_fallback(function(name)
	return dofile(nixCats.pawsible({ "allPlugins", "opt", "nvim-lspconfig" }) .. "/lsp/" .. name .. ".lua").filetypes or
		{}
end)
return {
	{
		"nvim-lspconfig",
		on_require = { "lspconfig" },
		lsp = function(plugin)
			vim.lsp.config(plugin.name, plugin.lsp or {})
			vim.lsp.enable(plugin.name)
		end,
		before = function(_)
			vim.lsp.config('*', {
				on_attach = lsp_on_attach,
			})
		end,
	},
	{
		"lua_ls",
		lsp = {
			filetypes = { 'lua' },
			settings = {
				Lua = {
					runtime = { version = 'LuaJIT' },
					formatters = {
						ignoreComments = true,
					},
					signatureHelp = { enabled = true },
					diagnostics = {
						globals = { "nixCats", "vim", },
						disable = { 'missing-fields' },
					},
					telemetry = { enabled = false },
				},
			},
		},
	},
	{
		"nixd",
		lsp = {
			filetypes = { 'nix' },
			settings = {
				nixd = {
					nixpkgs = {
						expr = nixCats.extra("nixdExtras.nixpkgs") or [[import <nixpkgs> {}]],
					},
					options = {
						nixos = {
							expr = nixCats.extra("nixdExtras.nixos_options")
						},
						["home-manager"] = {
							expr = nixCats.extra("nixdExtras.home_manager_options")
						}
					},
					formatting = {
						command = { "alejandra" }
					},
					diagnostic = {
						suppress = {
							"sema-escaping-with"
						}
					}
				}
			},
		},
	},
	{
		"lazydev.nvim",
		for_cat = "lua",
		cmd = { "LazyDev" },
		ft = "lua",
		after = function(_)
			require('lazydev').setup({
				library = {
					{ words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. '/lua' },
				},
			})
		end,
	},
	{
		"rust_analyzer",
		enabled = nixCats('rust') or false,
		lsp = {
			filetypes = { "rust" },

			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						buildScripts = { enable = true },
					},

					checkOnSave = {
						command = "clippy",
					},

					procMacro = {
						enable = true,
					},

					inlayHints = {
						bindingModeHints = { enable = true },
						chainingHints = { enable = true },
						closingBraceHints = { enable = true, minLines = 10 },
						closureReturnTypeHints = { enable = "always" },
						lifetimeElisionHints = { enable = "always" },
						parameterHints = { enable = true },
						reborrowHints = { enable = "always" },
						typeHints = { enable = true },
					},

					lens = {
						enable = true,
						implementations = true,
						references = true,
						run = true,
					},

					diagnostics = {
						enable = true,
						experimental = { enable = true },
					},

					rustfmt = {
						extraArgs = { "+nightly" },
					},
				},
			},
		},
	},
	{
		"crates.nvim",
		ft = { "toml" },
		after = function()
			require("crates").setup({
				completion = {
					crates = {
						enabled = true,
					},
				},
				lsp = {
					enabled = true,
				},
			})
		end,
	},
}
