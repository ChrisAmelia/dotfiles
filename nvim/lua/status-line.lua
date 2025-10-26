vim.api.nvim_command("hi StatusLine guibg=none gui=nocombine")

local Statusline = {}

local api = vim.api
local fn  = vim.fn

require('colors')
local stringutil = require('stringutil')
local component = require('component')

local icons = setmetatable({
  ["n"]  = "  ",
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

  codecompanion = { icon = "󰚩", bg = BLACK           , fg = ELECTRIC_BLUE },
  commit        = { icon = "", bg = CORAL_RED       , fg = WHITE         },
  css           = { icon = "", bg = ENDEAVOUR       , fg = WHITE         },
  edit          = { icon = "", bg = CORAL_RED       , fg = WHITE         },
  fugitive      = { icon = "", bg = CORAL_RED       , fg = WHITE         },
  go            = { icon = "", bg = CORNFLOWER_BLUE , fg = WHITE         },
  html          = { icon = "", bg = DEEP_RED        , fg = WHITE         },
  help          = { icon = "", bg = FERN_GREEN      , fg = WHITE         },
  java          = { icon = "", bg = ALIZARIN_CRIMSON, fg = WHITE         },
  javascript    = { icon = "", bg = COD_GRAY        , fg = GOLD          },
  jproperties   = { icon = "", bg = BLEACHED_CEDAR  , fg = WHITE         },
  json          = { icon = "", bg = CAMARONE        , fg = GREEN_YELLOW  },
  jsp           = { icon = "󰬷", bg = PIGMENT_INDIGO  , fg = WHITE         },
  leaderf       = { icon = "󰈳", bg = FUSCOUS_GRAY    , fg = DUST          },
  lua           = { icon = "", bg = MARINER         , fg = WHITE         },
  markdown      = { icon = "", bg = BLACK           , fg = WHITE         },
  merge         = { icon = "", bg = CORAL_RED       , fg = WHITE         },
  rust          = { icon = "", bg = DUST            , fg = BLACK         };
  sh            = { icon = "", bg = COD_GRAY        , fg = SULU          },
  sql           = { icon = "", bg = BIG_STONE       , fg = WHITE         },
  text          = { icon = "", bg = WHITE           , fg = BLACK         },
  vim           = { icon = "", bg = FOREST_GREEN    , fg = WHITE         },
  xml           = { icon = "", bg = MAKO            , fg = WHITE         },
  zsh           = { icon = "", bg = COD_GRAY        , fg = SULU          },

}

--- If value is not `nil`, then is a git repository,
--- especially check the presence of a .git directory.
--- @see string.find
local is_git_repository = function()
  local current_directory = fn.expand("%:p:h")
  local git_root = fn.finddir(".git/", current_directory .. ";")

  return string.find(git_root, ".git")
end

--- @return string # current branch name
local build_git_branch_component = function()
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
  local filename = fn.expand("%:t") -- file's name with extension: "file.txt"
  local fullpath = fn.expand("%:p") -- path to file: "/home/user/git_repo/path/to/file.txt"
  local current_directory = fn.expand("%:p:h")
  local git_directory = fn.finddir(".git/..", current_directory .. ";") -- "/home/user/git_repo"

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

  return component.build_element({
    separator_hl = "HlStatuslineSeparatorGitPath",
    main_hl = "HlStatuslineGitPath",
    bg = GOLD,
    fg = BLACK,
    value = icon .. " " .. path
  })
end

--- considering the fullpath of the current file being `/home/user/project/file`,
--- this returns `~/user/project`.
--- @return string # full path to current file
local build_fullpath_component = function()
  local icon = ""
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
    local begin_index = 3
    local end_index = #split_fullpath
    local slice = { unpack(split_fullpath, begin_index, end_index) }

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

  return component.build_element({
    separator_hl = "HlStatuslineSeparatorFullPath",
    main_hl = "HlStatuslineFullPath",
    bg = GOLD,
    fg = BLACK,
    value = icon .. " " .. path
  })
end

--- @return string # A string containing the icon and the filename
---                  following this format `"[ file.txt ]"`
local build_filename_component = function()
  local file = fn.expand("%:t")

  if file == "" then
    return ""
  end

  -- Default case, filetype not handled
  if extensions[vim.bo.filetype] == nil then
    return component.build_element({
      separator_hl = "HlDefaultSeparatorFile",
      main_hl = "HlDefaultFile",
      bg = WHITE,
      fg = BLACK,
      value = "" .. " " .. file
    })
  end

  local icon = extensions[vim.bo.filetype].icon
  local bg = extensions[vim.bo.filetype].bg
  local fg = extensions[vim.bo.filetype].fg

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
  local first_error_message =  first_error.message

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

--- setup {{{
local function set_statusline()
    vim.api.nvim_create_autocmd({'WinEnter', 'BufEnter'}, {
        pattern = '*',
        callback = function()
            vim.o.statusline = "%!v:lua.require('status-line').activate()"
        end
    })

    vim.api.nvim_create_autocmd({'WinLeave', 'BufLeave'}, {
        pattern = '*',
        callback = function()
            vim.o.statusline = "%!v:lua.require('status-line').inactivate()"
        end
    })

    vim.o.statusline = "%!v:lua.require('status-line').activate()"
end

set_statusline()
--- }}}

return Statusline
