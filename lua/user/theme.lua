local status_ok, base16 = pcall(require, 'base16')

vim.g.custome_theme = "onedark"

if status_ok then
  theme = vim.g.custome_theme
  -- 首次加载
  base16(base16.themes(theme), true)
  --
end

local M = {}

M.get = function(theme)
  if theme == nil then
    theme = vim.g.custome_theme
  end
  return require('hl_themes.' .. theme)
end

-- 定义背景
-- @param group 高亮名
-- @param col 颜色
local bg = function(group, col)
  cmd('hi ' .. group .. ' guibg=' .. col)
end

-- 定义前景
-- @param group 高亮名
-- @param col 颜色
local fg = function(group, col)
  cmd('hi ' .. group .. ' guifg=' .. col)
end

-- 定义前景和背景
-- @param group 高亮名
-- @param fgcol 前景
-- @param bgcol 背景
local fg_bg = function(group, fgcol, bgcol)
  cmd('hi ' .. group .. ' guifg=' .. fgcol .. ' guibg=' .. bgcol)
end

M.coloring = function() 
  local colors = M.get()

  -- Comments
  fg('Comment', colors.grey_fg .. ' gui=italic')

  -- Disable cusror line
  cmd('hi clear CursorLine')
  -- Line number
  fg('cursorlinenr', colors.white)

  -- same it bg, so it doesn't appear
  fg('EndOfBuffer', colors.black)

  -- For floating windows
  bg('NormalFloat', colors.darker_black)
  fg_bg('FloatBorder', colors.darker_black, colors.darker_black)

  -- Pmenu
  bg('Pmenu', colors.one_bg)
  bg('PmenuSbar', colors.one_bg2)
  bg('PmenuSel', colors.pmenu_bg)
  bg('PmenuThumb', colors.nord_blue)

  -- misc

  -- inactive statuslines as thin lines
  fg('StatusLineNC', colors.one_bg3 .. ' gui=underline')
  fg('LineNr', colors.grey)
  fg('NvimInternalError', colors.red)
  fg('VertSplit', colors.one_bg2)

  -- Plugin Highlights

  -- Dashboard
  fg('AlphaHeader', colors.light_grey)
  fg('AlphaButtons', colors.light_grey)
  fg('AlphaType', colors.blue)

  -- Git signs
  fg_bg('DiffAdd', colors.blue, 'NONE')
  fg_bg('DiffChange', colors.grey_fg, 'NONE')
  fg_bg('DiffChangeDelete', colors.red, 'NONE')
  fg_bg('DiffModified', colors.red, 'NONE')
  fg_bg('DiffDelete', colors.red, 'NONE')
  fg_bg('GitSignsCurrentLineBlame', colors.grey_fg, 'NONE')

  -- Indent blankline
  fg('IndentBlanklineChar', colors.line)
  fg('IndentBlanklineSpaceChar', colors.line)
  fg('IndentBlanklineIndent1', '#E06C75')
  fg('IndentBlanklineIndent2', '#E5C07B')
  fg('IndentBlanklineIndent3', '#98C379')
  fg('IndentBlanklineIndent4', '#56B6C2')
  fg('IndentBlanklineIndent5', '#61AFEF')
  fg('IndentBlanklineIndent6', '#C678DD')

  -- Cmp
  fg_bg('CmpItemAbbrDeprecated', '#808080', 'NONE' .. ' gui=strikethrough')
  fg_bg('CmpItemAbbrMatch', '#569CD6', 'NONE')
  fg_bg('CmpItemAbbrMatchFuzzy', '#569CD6', 'NONE')
  fg_bg('CmpItemKindVariable', '#9CDCFE', 'NONE')
  fg_bg('CmpItemKindInterface', '#9CDCFE', 'NONE')
  fg_bg('CmpItemKindText', '#9CDCFE', 'NONE')
  fg_bg('CmpItemKindFunction', '#C586c0', 'NONE')
  fg_bg('CmpItemKindMethod', '#C586C0', 'NONE')
  fg_bg('CmpItemKindKeyword', '#d4D4D4', 'NONE')
  fg_bg('CmpItemKindProperty', '#D4D4d4', 'NONE')
  fg_bg('CmpItemKindUnit', '#D4D4d4', 'NONE')

  -- Lsp diagnostics
  fg('DiagnosticHint', colors.purple)
  fg('DiagnosticError', colors.red)
  fg('DiagnosticWarn', colors.yellow)
  fg_bg('DiagnosticInformation', colors.green, colors.red)

  -- NvimTree
  fg('NvimTreeEmptyFolderName', colors.folder_bg)
  fg('NvimTreeEndOfBuffer', colors.darker_black)
  fg('NvimTreeFolderIcon', colors.folder_bg)
  fg('NvimTreeFolderName', colors.folder_bg)
  fg('NvimTreeGitDirty', colors.red)
  fg('NvimTreeIndentMarker', colors.one_bg2)
  bg('NvimTreeNormal', colors.darker_black)
  bg('NvimTreeNormalNC', colors.darker_black)
  fg('NvimTreeOpenedFolderName', colors.folder_bg)
  fg('NvimTreeRootFolder', colors.red .. ' gui=underline') -- enable underline for root folder in nvim tree
  fg('NvimTreeVertSplit', colors.darker_black)
  bg('NvimTreeVertSplit', colors.darker_black)
  fg_bg('NvimTreeStatuslineNc', colors.darker_black, colors.darker_black)
  fg_bg('NvimTreeWindowPicker', colors.red, colors.black2)

  -- Telescope
  fg_bg('TelescopeBorder', colors.darker_black, colors.darker_black)
  fg_bg('TelescopePromptBorder', colors.black2, colors.black2)
  fg_bg('TelescopePromptNormal', colors.white, colors.black2)
  fg_bg('TelescopePromptPrefix', colors.red, colors.black2)
  fg_bg('TelescopePreviewTitle', colors.black, colors.green)
  fg_bg('TelescopePromptTitle', colors.black, colors.red)
  fg_bg('TelescopeResultsTitle', colors.darker_black, colors.yellow)
  bg('TelescopeNormal', colors.darker_black)
  bg('TelescopeSelection', colors.black2)

  -- Renamer
  bg('RenamerNormal', colors.darker_black)
  fg_bg('RenamerBorder', colors.darker_black, colors.darker_black)
  fg_bg('RenamerTitle', colors.black, colors.blue)

  -- keybinds cheatsheet
  fg_bg('CheatsheetBorder', colors.black, colors.black)
  bg('CheatsheetSectionContent', colors.black)
  fg('CheatsheetHeading', colors.white)

  local section_title_colors = {
    colors.white,
    colors.blue,
    colors.red,
    colors.green,
    colors.yellow,
    colors.purple,
    colors.orange,
  }
  for i, color in ipairs(section_title_colors) do
    vim.cmd('highlight CheatsheetTitle' .. i .. ' guibg = ' .. color .. ' guifg=' .. colors.black)
  end
end



return M;
