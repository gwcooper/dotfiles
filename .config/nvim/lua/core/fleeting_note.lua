local m = {}

function m.file_exists(filename)
  local file = io.open(filename, "r")
  if file then
    io.close(file)
    return true
  else
    return false
  end
end

function m.write_to_file(filename, content)
  local file = io.open(filename, "w")
  if file then
    file:write(content)
    io.close(file)
  else
    print("Error: Unable to open file for writing.")
  end
end

function m.fleeting_note()
  -- Check if today's fleeting notes file exists already, create if not
  local noteFilename = os.getenv("HOME")
    .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/Redux/Fleeting/"
    .. os.date("%Y-%m-%d")
    .. ".md"

  if not m.file_exists(noteFilename) then
    local noteHeader = "# Notes for " .. os.date("%Y-%m-%d") .. "\n"
    m.write_to_file(noteFilename, noteHeader)
  end

  -- get the editor's max width and height
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  -- window size logic
  if width > 150 or height > 35 then
    local win_height = math.min(math.ceil(height * 3 / 4), 30)
    local win_width

    if width < 150 then
      win_width = math.ceil(width - 8)
    else
      win_width = math.ceil(width * 0.7)
    end

    -- settings for the window
    local opts = {
      relative = "editor",
      width = win_width,
      height = win_height,
      row = math.ceil((height - win_height) / 2),
      col = math.ceil((width - win_width) / 2),
      style = "minimal",
      border = "rounded",
    }

    -- create a new floating window, centered in the editor
    local buf = vim.api.nvim_create_buf(false, true)
    local window_id = vim.api.nvim_open_win(buf, true, opts)
    local open_file_command = "e " .. noteFilename
    vim.api.nvim_command(open_file_command)
    -- add newlines and current time
    vim.fn.appendbufline(buf, "$", "")
    vim.fn.appendbufline(buf, "$", os.date("%H:%M"))
    vim.fn.appendbufline(buf, "$", "")

    -- move cursor to the bottom of the buffer
    local buf_maxline = #vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    vim.api.nvim_win_set_cursor(window_id, { buf_maxline, 0 })

    -- when the buffer is closed, force unload the file
    -- this means that if the buffer is left with ":wq" it will save as expected
    -- and if left with just ":q" the changes, including inserted timestamps will be discarded

    vim.api.nvim_create_autocmd({ "WinClosed" }, {
      callback = function(event)
        local win_closed_event = event.event == "WinClosed" and event.match == tostring(window_id)
        if win_closed_event then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end,
    })
  end
end

vim.api.nvim_create_user_command("Fleeting", m.fleeting_note, {})
