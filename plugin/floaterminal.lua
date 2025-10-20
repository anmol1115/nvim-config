local state = {
  floating = {
    buf = -1,
    win = -1
  }
}

-- Function to create a floating window
local function open_floating_window(opts)
  opts = opts or {}
  -- Default to 80% of editor size
  local win_width = opts.width or math.floor(vim.o.columns * 0.8)
  local win_height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate center position
  local row = math.floor((vim.o.lines - win_height) / 2)
  local col = math.floor((vim.o.columns - win_width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- create a scratch buffer
  end

  local win_config = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "double", -- optional: "single", "double", "shadow", etc.
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

local toggleTerminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = open_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command("Floaterminal", toggleTerminal, {})
vim.keymap.set("n", "<space>t", toggleTerminal)
