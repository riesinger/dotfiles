require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
	refactor = {
    highlight_definitions = {enable = true},
    highlight_current_scope = {enable = false},
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'grn',
      },
    },
	},
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"go",
		"java",
		"javascript",
		"jsdoc",
		"json",
		"kotlin",
		"lua",
		"python",
		"regex",
		"rust",
		"toml",
		"tsx",
		"typescript",
	}
}
