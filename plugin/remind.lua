local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local previewers = require('telescope.previewers')
local themes = require('telescope.themes')
local actions = require('telescope.actions')

local function read_keymaps_json()
  -- get the directory of this Lua file
  local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
  local path = script_dir .. "keymaps.json"

  local ok, content = pcall(vim.fn.readfile, path)
  if not ok then
    vim.notify("Failed to read " .. path, vim.log.levels.ERROR)
    return {}
  end

  local ok2, decoded = pcall(vim.fn.json_decode, content)
  if not ok2 then
    vim.notify("Invalid JSON in " .. path, vim.log.levels.ERROR)
    return {}
  end

  return decoded
end

local function format_data()
  local data = read_keymaps_json()
  local entries = {}

  for section, map in pairs(data) do
    for _, m in ipairs(map) do
      for keymap, description in pairs(m) do
        entries["[" .. section .. "]" .. description] = keymap
      end
    end
  end
  return entries
end

local keysFromHashMap = function(loadedConfig)
  local keyset = {}

  for k, _ in pairs(loadedConfig) do
    table.insert(keyset, k)
  end
  return keyset
end

local function show_keymaps(opts)
  opts = opts or {}
  opts = themes.get_cursor(vim.tbl_deep_extend("force", {
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    layout_config = {
      preview_width = 0.2,
      height = 20,
    },
  }, opts))

  local data = format_data()

  pickers.new(opts, {
    prompt_title = "Keymaps",
    finder = finders.new_table {
      results = keysFromHashMap(data)
    },
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
        local output = data[entry.value]
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { output })
        return { output }
      end,
    }),
  }):find()
end

vim.api.nvim_create_user_command("Remind", show_keymaps, {})
vim.keymap.set('n', '<space>rr', show_keymaps)
