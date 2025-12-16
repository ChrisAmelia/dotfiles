local Statusline = {}

local api = vim.api
local fn  = vim.fn

require('colors')
local stringutil = require('stringutil')
local component = require('component')

local icons = setmetatable({
  ["n"]  = " 󰊴 ",
  ["no"] = "N·Operator Pending",
  ["v"]  = " 󰈈 ",
  ["V"]  = " 󰈈 ",
  ["^V"] = " 󰈈 ",
  ["s"]  = "  ",
  ["S"]  = "S·Line",
  ["^S"] = "S·Block",
  ["i"]  = " 󰭟 ",
  ["ic"] = " 󰭟 ",
  ["ix"] = " 󰭟 ",
  ["R"]  = "  ",
  ["Rv"] = "  ",
  ["c"]  = "  ",
  ["cv"] = "  ",
  ["ce"] = "  ",
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

  codecompanion = { icon = "󰚩", bg = BLACK           , fg = ELECTRIC_BLUE },
  commit        = { icon = "", bg = CORAL_RED       , fg = WHITE         },
  css           = { icon = "", bg = ENDEAVOUR       , fg = WHITE         },
  dockerfile    = { icon = "", bg = LIGHT_BLUE      , fg = MOBY_BLUE     },
  edit          = { icon = "", bg = CORAL_RED       , fg = WHITE         },
  elixir        = { icon = "", bg = LIGHT_BLUE      , fg = MARDI_GRAS    },
  fugitive      = { icon = "", bg = CORAL_RED       , fg = WHITE         },
  go            = { icon = "", bg = CORNFLOWER_BLUE , fg = WHITE         },
  help          = { icon = "", bg = FERN_GREEN      , fg = WHITE         },
  html          = { icon = "", bg = DEEP_RED        , fg = WHITE         },
  java          = { icon = "", bg = ALIZARIN_CRIMSON, fg = WHITE         },
  javascript    = { icon = "", bg = COD_GRAY        , fg = GOLD          },
  jproperties   = { icon = "", bg = BLEACHED_CEDAR  , fg = WHITE         },
  json          = { icon = "", bg = CAMARONE        , fg = GREEN_YELLOW  },
  jsp           = { icon = "󰬷", bg = PIGMENT_INDIGO  , fg = WHITE         },
  leaderf       = { icon = "󰈳", bg = FUSCOUS_GRAY    , fg = DUST          },
  lua           = { icon = "", bg = MARINER         , fg = WHITE         },
  markdown      = { icon = "", bg = BLACK           , fg = WHITE         },
  merge         = { icon = "", bg = CORAL_RED       , fg = WHITE         },
  rust          = { icon = "", bg = MATTERHORN      , fg = PORSCHE       };
  sh            = { icon = "", bg = COD_GRAY        , fg = SULU          },
  sql           = { icon = "", bg = BIG_STONE       , fg = WHITE         },
  text          = { icon = "", bg = WHITE           , fg = BLACK         },
  vim           = { icon = "", bg = FOREST_GREEN    , fg = WHITE         },
  xml           = { icon = "󰗀", bg = MAKO            , fg = WHITE         },
  zsh           = { icon = "", bg = COD_GRAY        , fg = SULU          },

}

--- @return boolean # true if current directory is a git repo, else false
local is_git_repository = function()
  local current_directory = fn.expand("%:p:h")

  return fn.finddir(".git/", current_directory .. ";") ~= ''
end

--- @return string # current branch name
local build_git_branch_component = function()
  local branch_name = vim.b.git_branch_name or ""

  local icon = ""

  if branch_name == "master" or branch_name == "main" then
    icon = ""
  elseif branch_name:lower():find("fix") then
    icon = ""
    branch_name = branch_name:sub(5, -1)
  elseif branch_name:lower():find("feat") then
    icon = ""
    branch_name = branch_name:sub(6, -1)
  else
    icon = ""
  end

  return component.build_element({
      separator_hl = "HlStatuslineSeparatorBranch",
      main_hl = "HlStatuslineBranch",
      bg = BLUE_RIBBON,
      fg = WHITE,
      value = icon .. " " .. branch_name
    })
end

--- @return string # git relative path of current file
local build_git_relative_path_component = function()
  local icon = ""

  local current_directory = fn.expand("%:p:h")

  -- When opening an empty buffer
  if current_directory == "" then
    return ""
  end

  -- From "/home/user/git_repo/path/to/file.txt"
  -- to "path/to"
  local git_directory = fn.finddir(".git/..", current_directory .. ";") -- "/home/user/git_repo"
  local path = current_directory:sub(git_directory:len() + 2)

  return component.build_element({
    separator_hl = "HlStatuslineSeparatorGitPath",
    main_hl = "HlStatuslineGitPath",
    bg = GOLD,
    fg = BLACK,
    value = icon .. " " .. path
  })
end

--- Returns the head path.
--- Considering the fullpath of the current file being `/etc/user/project/file`, this returns `/etc/user/project`.
--- If the file is located somewhere in `/home/user/`, then `/home/user` is shorten for `~`.
--- @return string # full path to current file
local build_fullpath_component = function()
  local icon = " 󰇝"
  local fullpath = fn.expand("%:p:h") -- head path to file: "/home/user/path/to/"

  -- When opening an empty buffer
  if fullpath == "" then
    return ""
  end

  -- /home/user/path/to
  --           ^
  --           end_index
  local _, end_index = fullpath:find(os.getenv("HOME"))

  -- replace '/home/user' with '~'
  if end_index ~= nil then
    fullpath = "~" .. fullpath:sub(end_index + 1)
  end

  return component.build_element({
    separator_hl = "HlStatuslineSeparatorFullPath",
    main_hl = "HlStatuslineFullPath",
    bg = GOLD,
    fg = BLACK,
    value = icon .. " " .. fullpath
  })
end

--- @return string # A string containing the icon and the filename
---                  following this format `"[ file.txt ]"`
local build_filename_component = function()
  local file = fn.expand("%:t")
  local filetype = vim.bo.filetype

  if file == "" then
    return ""
  end

  -- Default case, filetype not handled
  if extensions[filetype] == nil then
    return component.build_element({
      separator_hl = "HlDefaultSeparatorFile",
      main_hl = "HlDefaultFile",
      bg = WHITE,
      fg = BLACK,
      value = "" .. " " .. file
    })
  end

  local icon = extensions[filetype].icon
  local bg = extensions[filetype].bg
  local fg = extensions[filetype].fg

  return component.build_element({
    separator_hl = "HlStatuslineSeparatorFile",
    main_hl = "HlStatuslineFile",
    bg = bg,
    fg = fg,
    value = icon .. " " .. file
  })
end

--- Set highlight for given mode
local draw_colors = function(mode)
  local colors = {

    n  = "hi Mode guibg=none guifg=" .. BLACK,
    i  = "hi Mode guibg=none guifg=" .. WHITE,
    ic = "hi Mode guibg=none guifg=" .. MILANO_RED,
    R  = "hi Mode guibg=none guifg=" .. FLUSH_ORANGE,
    v  = "hi Mode guibg=none guifg=" .. HOT_PINK,
    V  = "hi Mode guibg=none guifg=" .. HOT_PINK,
    c  = "hi Mode guibg=none guifg=" .. INCH_WORM,

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

  return component.build_element({
      has_separator_left = false,
      has_separator_right = false,
      main_hl = "HlStatuslineWarning",
      bg = "none",
      fg = RIPE_LEMON,
      value = "" .. icon .. " :" .. #warns.. ""
    })
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
  local first_error_message = first_error.message

  if #first_error_message > 20 then
    first_error_message = first_error_message:sub(1, 20) .. "..."
  end

  return component.build_element({
    has_separator_left = false,
    has_separator_right = false,
    main_hl = "HlStatuslineErrors",
    bg = "none",
    fg = SALMON,
    value = "" .. line_icon .. first_error_line .. " 󰄽" .. first_error_message .. "󰄾" .. (count == 1 and "" or ", #" .. count) .. ""
  })
end

--- Returns added, changed, deleted lines
--- @return string
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

  return component.build_element({
    has_separator_left = false,
    has_separator_right = false,
    main_hl = "HlStatuslineGutter",
    bg = "none",
    fg = GOLD,
    value = hunks
  })
end

--- Default nvim icon  
--- @return string
local build_nvim_component = function()
  return component.build_element({
    has_separator_left = false,
    has_separator_right = false,
    main_hl = "HlNvimIcon",
    bg = "none",
    fg = FOREST_GREEN,
    value = "  "
  })
end

--- Statusline active
function Statusline.activate()
  local statusline = ""

  if is_git_repository() then
    -- Git branch
    statusline = statusline .. build_git_branch_component() .. " "

    -- Current directory
    local current_path = build_git_relative_path_component()

    if current_path ~= "" then
      statusline = statusline .. current_path
      statusline = statusline .. " "
    end
  else
    -- Default
    statusline = statusline .. build_nvim_component()

    -- Directory
    local currentPath = build_fullpath_component()

    if currentPath ~= "" then
      statusline = statusline .. currentPath

      statusline = statusline .. " "
    end
  end

  -- Current file
  local current_file = build_filename_component()

  if current_file ~= "" then
    statusline = statusline  .. current_file

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
    statusline = statusline .. warnings
  end

  -- LSP diagnostics errors
  local errors = build_errors_component()

  if errors ~= "" then
    statusline = statusline .. errors
  end

  -- Right side items
  statusline = statusline .."%="

  -- Gutter
  local gutters = build_gutter_component()

  if gutters ~= "" then
    statusline = statusline .. gutters
  end

  return statusline
end

--- Statusline inactive
function Statusline.inactivate()
  local filename = fn.expand("%F")

  return filename
end

return Statusline
