local Statusline = {}

local api = vim.api
local fn  = vim.fn

require('colors')
local stringutil = require('stringutil')
local component = require('component')

-- Colors to set per filetype
COLOR_FILE = ""
COLOR_FILE_NAME = ""

-- Separators
SEPARATOR_LEFT = ""
SEPARATOR_RIGHT = ""

-- Git branch highlight
HIGHLIGHT_GIT = "SEPARATOR_GIT"
HIGHLIGHT_GIT_NAME = "BRANCH_NAME"

-- Current path highlight
HIGHLIGHT_PATH = "SEPARATOR_CURRENT"
HIGHLIGHT_CURRENT_PATH = "CURRENT_PATH"

-- Current file highlight
HIGHLIGHT_FILE = "SEPARATOR_FILE"
HIGHLIGHT_FILE_NAME = "CURRENT_FILE"

-- Warning, errors highlights
HIGHLIGHT_WARNING = "LSP_WARNING"
HIGHLIGHT_ERROR = "LSP_ERROR"

-- Gutters
HIGHLIGHT_GUTTER = "SEPARATOR_GUTTER"
HIGHLIGHT_GUTTER_NAME = "STATUS_GUTTER"

-- Function highlight
HIGHLIGHT_FUNCTION = "LSP_FUNCTION"

local icons = setmetatable({
  ["n"]  = " 󰘳 ",
  ["no"] = "N·Operator Pending",
  ["v"]  = " 󰈈 ",
  ["V"]  = " 󰈈 ",
  ["^V"] = " 󰈈 ",
  ["s"]  = "  ",
  ["S"]  = "S·Line",
  ["^S"] = "S·Block",
  ["i"]  = " 󰞇 ",
  ["ic"] = " 󰞇 ",
  ["ix"] = " 󰞇 ",
  ["R"]  = "  ",
  ["Rv"] = "  ",
  ["c"]  = "  ",
  ["cv"] = "  ",
  ["ce"] = "  ",
  ["r"]  = "Prompt",
  ["rm"] = "More",
  ["r?"] = "Confirm",
  ["!"]  = "Shell",
  ["t"]  = "TERMINAL"
}, {
  -- fix weird issues
  __index = function(_, _)
    return " 󰶹 " -- V-Block
  end
}
)

-- Extensions icon
local extensions = {

  commit      = "",
  css         = "",
  edit        = "",
  fugitive    = "",
  go          = "",
  html        = "",
  help        = "",
  java        = "",
  javascript  = "",
  jproperties = "",
  json        = "",
  jsp         = "",
  leaderf     = "󰈳",
  lua         = "",
  markdown    = "",
  merge       = "",
  rust        = "";
  sh          = "",
  sql         = "",
  text        = "",
  vim         = "",
  xml         = "",
  zsh         = "",

}

--- If value is not `nil`, then is a git repository,
--- especially check the presence of a .git directory.
---@see string.find
local is_git_repository = function()
  local current_dir = fn.expand("%:p:h")
  local git_root = fn.finddir(".git/", current_dir .. ";")

  return string.find(git_root, ".git")
end

--- @return string # current branch name
local get_git_branch_name = function()
  local branch_name = vim.b.gitBranchName or ""

  local icon = ""

  if branch_name == "master" or branch_name == "main" then
    icon = ""
  elseif string.find(string.lower(branch_name), "fix") then
    icon = ""
    branch_name = branch_name:sub(5, -1)
  elseif string.find(string.lower(branch_name), "feat") then
    icon = ""
    branch_name = branch_name:sub(6, -1)
  else
    icon = ""
  end

  return icon .. " " .. branch_name
end

--- @return string # git relative path of current file
local get_git_relative_path = function()
  local icon = ""
  local filename = fn.expand("%:t") -- file's name with extension: "file.txt"
  local fullpath = fn.expand("%:p") -- path to file: "/home/user/git_repo/path/to/file.txt"
  local current_dir = fn.expand("%:p:h")
  local git_directory = fn.finddir(".git/..", current_dir .. ";") -- "/home/user/git_repo"

  -- When opening an empty buffer
  if fullpath == "" then
    return ""
  end

  -- From "/home/user/git_repo/path/to/file.txt"
  --       ^^^^^^^^^^^^^^^^^^^         ^^^^^^^^^
  --       len(gitDirectory)           len(filename)
  -- to "path/to"
  local begin_index = string.len(git_directory) + 2
  local end_index = string.len(fullpath) - string.len(filename) - 1
  local path = string.sub(fullpath, begin_index, end_index)

  return icon .. " " .. path
end

--- considering the fullpath of the current file being `/home/user/project/file`,
--- this returns `~/user/project`.
--- @return string # full path to current file
local get_fullpath = function()
  local icon = ""
  local filename = fn.expand("%:t") -- file's name with extension: "file.txt"
  local fullpath = fn.expand("%:p") -- path to file: "/home/user/path/to/file.txt"

  -- When opening an empty buffer
  if fullpath == "" then
    return ""
  end

  local split_fullpath = stringutil.split(fullpath, "/") -- {"home", "user", "path", "to", "file.txt"}
  local shorten_path = nil
  local shift; -- remove the last '/' from "~/project/" (HOME) or "/usr/lib/" (ROOT)

  -- Replace "/home/user/" with "~"
  if split_fullpath[1] == "home" then
    shorten_path = "~/"
    shift = 2; -- introducing the tilde '~' shifts the last '/' from 1 to the right thus removing the two last chars

    -- From {"home", "user", "path", "to", "file.txt"}
    -- to {"path", "to", "file.txt"} thus begin index at 3
    local beginIndex = 3
    local endIndex = #split_fullpath
    local slice = { unpack(split_fullpath, beginIndex, endIndex) }

    -- Concatenate slice: "~/path/to/file.txt"
    for _, value in pairs(slice) do
      shorten_path = shorten_path .. value .. "/"
    end
  else
    shift = 1;
  end

  -- shorten_path: current directory is at $HOME
  -- fullpath: current directory is at root "/"
  local path = shorten_path or fullpath

  -- Strip the last '/' and the file's name
  -- path is "~/home/user/path/to"
  path = string.sub(path, 0, string.len(path) - string.len(filename) - shift)

  return icon .. " :" .. path
end

--- @return string bg the background color.
--- @return string fg the foreground color.
local get_colors_per_filetype = function(filetype)
  local separator_color, filename_color

  separator_color, filename_color = WHITE, BLACK

  if filetype == 'css' then
    separator_color, filename_color = ENDEAVOUR, WHITE
  end

  if filetype == 'go' then
    separator_color, filename_color = CORNFLOWER_BLUE, WHITE
  end

  if filetype == 'help' then
    separator_color, filename_color = FERN_GREEN, WHITE
  end

  if filetype == 'html' then
    separator_color, filename_color = DEEP_RED, WHITE
  end

  if filetype == 'java' then
    separator_color, filename_color = ALIZARIN_CRIMSON, WHITE
  end

  if filetype == 'javascript' then
    separator_color, filename_color = COD_GRAY, GOLD
  end

  if filetype == 'json' then
    separator_color, filename_color = CAMARONE, GREEN_YELLOW
  end

  if filetype == 'jproperties' then
    separator_color, filename_color = BLEACHED_CEDAR, WHITE
  end

  if filetype == 'jsp' then
    separator_color, filename_color = PIGMENT_INDIGO, WHITE
  end

  if filetype == 'leaderf' then
    separator_color, filename_color = FUSCOUS_GRAY, DUST
  end

  if filetype == 'lua' then
    separator_color, filename_color = MARINER, WHITE
  end

  if filetype == 'markdown' then
    separator_color, filename_color = BLACK, WHITE
  end

  if filetype == 'rust' then
    separator_color, filename_color = DUST, BLACK
  end

  if filetype == 'sh' or filetype == 'zsh' then
    separator_color, filename_color = COD_GRAY, SULU
  end

  if filetype == 'sql' then
    separator_color, filename_color = BIG_STONE, WHITE
  end

  if filetype == 'text' then
    separator_color, filename_color = WHITE, BLACK
  end

  if filetype == 'vim' then
    separator_color, filename_color = FOREST_GREEN, WHITE
  end

  if filetype == 'xml' then
    separator_color, filename_color = MAKO, WHITE
  end

  return separator_color, filename_color
end

--- @return string # A string containing the icon and the filename.
local build_filename_component = function()
  local file = fn.expand("%:t")
  local icon = extensions[vim.bo.filetype]

  if file == "" then
    return ""
  end

  -- No icon for current filetype
  if icon == nil then
    icon = ""
  end

  -- Initialize colors for separators and file's name
  COLOR_FILE, COLOR_FILE_NAME = get_colors_per_filetype(vim.bo.filetype)

  return icon .. " " .. file
end

--- Set highlight for given mode
local draw_colors = function(mode)
  local colors = {

    n  = "hi Mode guibg=none guifg=none",
    i  = "hi Mode guibg=none guifg=" .. HARLEQUIN,
    ic = "hi Mode guibg=none guifg=" .. MILANO_RED,
    R  = "hi Mode guibg=none guifg=" .. FLUSH_ORANGE,
    v  = "hi Mode guibg=none guifg=" .. HOT_PINK,
    V  = "hi Mode guibg=none guifg=" .. HOT_PINK,
    c  = "hi Mode guibg=none guifg=" .. MALIBU,

  }

  if colors[mode] == nil then
    api.nvim_command("hi Mode guibg=none guifg=" .. MALIBU .. " gui=bold")
  else
    api.nvim_command(colors[mode])
  end
end

--- @return string # the warnings
local build_warnings_component = function()
  local warns = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local icon = ""

  if #warns == 0 then
    return ""
  end

  return "" .. icon .. " :" .. #warns.. ""
end

--- @return string # the first error found
local build_errors_component = function()
  local errors = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local line_icon = "L"
  local count = #errors

  if count == 0 then
    return ""
  end

  local first_error = errors[1]
  local first_error_line = first_error.lnum + 1
  local first_error_message =  first_error.message

  if count == 1 then
    return "" .. line_icon .. first_error_line .. " 󰄽" .. first_error_message .. "󰄾" .. ""
  else
    return "" .. line_icon .. first_error_line .. " 󰄽" .. first_error_message .. "󰄾, #" .. count  .. ""
  end
end

--- Returns added, changed, deleted lines
local build_gutter_component = function()
  local gutter = fn.GitGutterGetHunkSummary()
  local added, changed, deleted = gutter[1], gutter[2], gutter[3]

  if (added == 0) and (changed == 0) and (deleted == 0) then
    return ""
  end

  local hunks = "󰍉:"

  if added ~= 0 then
    hunks = hunks .. "+" .. added
  end

  if changed ~= 0 then
    hunks = hunks .. "~" .. changed
  end

  if deleted ~= 0 then
    hunks = hunks .. "-" .. deleted
  end

  return hunks
end

--- Statusline active
function Statusline.activeLine()
  local statusline = ""

  if is_git_repository() then
    -- Git branch
    local branch_name = get_git_branch_name()

    statusline = statusline .. component.build_element({
      separator_hl = HIGHLIGHT_GIT,
      main_hl = HIGHLIGHT_GIT_NAME,
      bg = BLUE_RIBBON,
      fg = WHITE,
      value = branch_name
    })

    statusline = statusline .. " "

    -- Current directory
    local current_path = get_git_relative_path()

    if current_path ~= "" then
      statusline = statusline .. component.build_element({
        separator_hl = HIGHLIGHT_PATH,
        main_hl = HIGHLIGHT_CURRENT_PATH,
        bg = GOLD,
        fg = BLACK,
        value = current_path
      })

      statusline = statusline .. " "
    end
  else
    -- GitHub icon
    api.nvim_command("hi " .. HIGHLIGHT_GIT_NAME .. " guifg=" .. WHITE  .. " guibg=none")
    statusline = statusline .. "%#" .. HIGHLIGHT_GIT_NAME .. "#"
    statusline = statusline .. "  "
    statusline = statusline .. " "

    -- Directory
    local currentPath = get_fullpath()

    if currentPath ~= "" then
      statusline = statusline .. component.build_element({
        separator_hl = HIGHLIGHT_PATH,
        main_hl = HIGHLIGHT_CURRENT_PATH,
        bg = GOLD,
        fg = BLACK,
        value = currentPath
      })

      statusline = statusline .. " "
    end
  end

  -- Current file
  local current_file = build_filename_component()

  if current_file ~= "" then
    statusline = statusline  .. component.build_element({
      separator_hl = HIGHLIGHT_FILE,
      main_hl = HIGHLIGHT_FILE_NAME,
      bg = COLOR_FILE,
      fg = COLOR_FILE_NAME,
      value = current_file
    })

    statusline = statusline .. " "
  end

  -- Mode
  local mode = api.nvim_get_mode()['mode']

  draw_colors(mode)

  statusline = statusline .. "%#Mode#" .. icons[mode]
  statusline = statusline .. " "

  -- LSP diagnostics warnings
  local warnings = build_warnings_component()

  if warnings ~= "" then
    api.nvim_command("hi " .. HIGHLIGHT_WARNING .. " guifg=" .. RIPE_LEMON .. " guibg=none")
    statusline = statusline .. "%#" .. HIGHLIGHT_WARNING .. "#"
    statusline = statusline .. warnings
  end

  -- LSP diagnostics errors
  local errors = build_errors_component()

  if errors ~= "" then
    api.nvim_command("hi " .. HIGHLIGHT_ERROR .. " guifg=" .. SALMON .. " guibg=none")
    statusline = statusline .. "%#" .. HIGHLIGHT_ERROR .. "#"
    statusline = statusline .. errors
    statusline = statusline .. " "
  end

  -- Right side items
  statusline = statusline .."%="

  -- Gutter
  local gutters = build_gutter_component()

  if gutters ~= "" then
    api.nvim_command("hi " .. HIGHLIGHT_GUTTER_NAME .. " guifg=" .. GOLD .. " guibg=none")
    statusline = statusline .. "%#" .. HIGHLIGHT_GUTTER_NAME .. "#"
    statusline = statusline .. gutters
    statusline = statusline .. " "
  end

  return statusline
end

--- Statusline inactive
function Statusline.inactiveLine()
  local filename = fn.expand("%F")

  return filename
end

return Statusline
