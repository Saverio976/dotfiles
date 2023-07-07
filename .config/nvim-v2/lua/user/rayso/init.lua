local rayzo = require('rayso')

local open_cmd = nil

if vim.fn.executable('xdg-open') then
  open_cmd = 'xdg-open'
elseif vim.fn.executable('firefox') then
  open_cmd = 'firefox'
elseif vim.fn.executable('chrome-browser') then
  open_cmd = 'chrome-browser'
else
  open_cmd = 'open'
end


rayzo.setup({
  base_url = 'https://ray.so/', -- Default URL
  open_cmd = open_cmd, -- On MacOS, will open with open -a firefox.app. Other OS's are untested.
  options = {
    background = true, -- If the screenshot should have a background.
    dark_mode = true, -- If the screenshot should be in dark mode.
    logging_path = '', -- Path to create a log file in.
    logging_file = 'rayso', -- Name of log file, will be a markdown file, ex rayso.md.
    logging_enabled = false, -- If you enable the logging file.
    padding = 32, -- The default padding that the screenshot will have.
    theme = 'breeze', -- Theme
    title = 'Untitled', -- Default title
  }
})
