local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local theme = require("telescope.themes")
local actions = require("telescope.actions")
local conf = require("telescope.config").values

local config = {
	{ "nvim", "gcc", "Comment current line in Normal mode" },
	{ "nvim", "[count]gcc", "Comment number of lines in Normal mode" },
	{ "nvim", "gc", "Comment current line in Visual mode" },
	{ "nvim", "C-h", "Move left in insert and command mode" },
	{ "nvim", "C-j", "Move down in insert and command mode" },
	{ "nvim", "C-k", "Move up in insert and command mode" },
	{ "nvim", "C-l", "Move right in insert and command mode" },
	{ "nvim", "C-i", "Create new line above the cursor" },
	{ "nvim", "C-o", "Create new line below the cursor" },
	{ "nvim", '"+p', "Paste from clipboard" },
	{ "nvim", '"+y', "Yank to clipboard" },
	{ "completion", "C-n", "Select below in dropdown" },
	{ "completion", "C-p", "Select above in dropdown" },
	{ "lsp", "K", "Definition of item under cursor" },
	{ "lsp", "<space>ca", "Suggest code actions" },
	{ "formatting", "<space>gf", "Formate code" },
	{ "telescope", "<space>ff", "Fuzzy find file in current directory" },
	{ "telescope", "<space>fg", "Fuzzy find keyword" },
	{ "telescope", "<space>fb", "Fuzzy find file in current buffer" },
	{ "telescope", "<space>fh", "Fuzzy find help" },
	{ "tmux", "C-b h", "Move to the left pane" },
	{ "tmux", "C-b j", "Move to the below pane" },
	{ "tmux", "C-b k", "Move to the above pane" },
	{ "tmux", "C-b l", "Move to the right pane" },
	{ "tmux", "C-b H", "Resize divider 10 units to left" },
	{ "tmux", "C-b J", "Resize divider 10 units to below" },
	{ "tmux", "C-b K", "Resize divider 10 units to above" },
	{ "tmux", "C-b L", "Resize divider 10 units to right" },
	{ "tmux", "C-b x", "Kill current pane" },
	{ "tmux", "C-b &", "Kill current window" },
	{ "tmux", "C-b d", "Detach from tmux" },
	{ "tmux", "C-b c", "Create New tmux window" },
}

local formatConfig = function(loadedConfig)
	loadedConfig = loadedConfig or {}
	local formatted = {}
	for _, entry in ipairs(loadedConfig) do
		local key = string.format("[%s]%s", entry[1], entry[3])
		formatted[key] = entry[2]
	end
	return formatted
end

local keysFromHashMap = function(loadedConfig)
	local keyset = {}
	local n = 0

	for k, _ in pairs(loadedConfig) do
		n = n + 1
		keyset[n] = k
	end
	return keyset
end

local commands = function(opts)
	opts = opts or {}
	local f_config = formatConfig(config)
	pickers
		.new(opts, {
			prompt_title = "Function",
			finder = finders.new_table({
				results = keysFromHashMap(f_config),
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(bufnr)
				actions.select_default:replace(function()
					actions.close(bufnr)
				end)
				return true
			end,
			previewer = previewers.new_buffer_previewer({
				title = "Command",
				define_preview = function(self, entry)
					local output = f_config[entry.value]
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { output })
					return { output }
				end,
			}),
		})
		:find()
end

local function custom_cursor_theme(opts)
	opts = opts or {}
	return theme.get_cursor(vim.tbl_deep_extend("force", {
		layout_config = {
			results_width = 0.8,
			preview_width = 0.2,
		},
	}, opts))
end

function M.execute()
	commands(custom_cursor_theme({}))
end

return M
