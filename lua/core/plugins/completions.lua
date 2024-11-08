-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

local status_cmp, cmp = pcall(require, "cmp")
if not status_cmp then
	return
end

local status_luasnip, luasnip = pcall(require, "luasnip")
if not status_luasnip then
	return
end

local status_lspkind, lspkind = pcall(require, "lspkind")
if not status_lspkind then
	return
end

-- Tailwindcss completion
require("tailwindcss-colorizer-cmp").setup({
	color_square_width = 2,
})

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- local kind_icons = {
--     File          = "󰈙 ",
--     Module        = " ",
--     Namespace     = "󰌗 ",
--     Package       = " ",
--     Class         = "󰌗 ",
--     Method        = "󰆧 ",
--     Property      = " ",
--     Field         = " ",
--     Constructor   = " ",
--     Enum          = "󰕘 ",
--     Interface     = "󰕘 ",
--     Function      = "󰊕 ",
--     Variable      = "󰆧 ",
--     Constant      = "󰏿 ",
--     String        = "󰀬  ",
--     Number        = "󰎠 ",
--     Boolean       = "◩ ",
--     Array         = "󰅪  ",
--     Object        = "󰅩  ",
--     Key           = "󰌋 ",
--     Null          = "󰟢 ",
--     EnumMember    = " ",
--     Struct        = "󰌗 ",
--     Event         = " ",
--     Operator      = "󰆕 ",
--     TypeParameter = "󰊄 ",
-- }
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-c>"] = cmp.mapping.complete({}),
		["<C-e>"] = cmp.mapping.close(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<ESC>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		col_offset = -3, -- align the abbr and word on cursor (due to fields order below)
		completion = cmp.config.window.bordered({
			border = "rounded",
			-- winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:PmenuSel,Search:None",
		}),
		documentation = cmp.config.window.bordered({
			border = "single",
		}),
	},
	sources = cmp.config.sources({
		{
			name = "luasnip",
			group_index = 1,
			priority = 1000,
			option = { use_show_condition = true },
			-- Prevents snippets from being triggered when typing inside a string
			entry_filter = function()
				local context = require("cmp.config.context")
				return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
			end,
		},
		{
			name = "nvim_lsp",
			group_index = 2,
			priority = 500,
		},
		{
			name = "nvim_lsp_signature_help",
			group_index = 3,
		},
		{
			name = "path",
			group_index = 4,
		},
		{
			name = "buffer",
			group_index = 5,
			option = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
			},
		},
	}),
	formatting = {
		-- Credit to:
		fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format({
			mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			maxwidth = 75, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			menu = { -- showing type in menu
				nvim_lsp = "[LSP]",
				path = "[Path]",
				buffer = "[Buffer]",
				luasnip = "[Snippet]",
			},
			before = function(entry, vim_item) -- for tailwind css autocomplete
				if vim_item.kind == "Color" and entry.completion_item.documentation then
					local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
					if r then
						local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
						local group = "Tw_" .. color
						if vim.fn.hlID(group) < 1 then
							vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
						end
						vim_item.kind = "■" -- or "⬤" or anything
						vim_item.kind_hl_group = group
						return vim_item
					end
				end
				-- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
				-- or just show the icon
				vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
				return vim_item
			end,
		}),
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})

require("luasnip.loaders.from_vscode").lazy_load()
