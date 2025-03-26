local gruvbox = require("gruvbox")
require("gruvbox").setup({
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = false,
  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = false,
  },
  strikethrough = false,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true,
  contrast = "hard",
  palette_overrides = {
  },
  overrides = {
        ["@comment"] = { fg = "#2ea542" },
        ["@function"] = { fg = gruvbox.palette.bright_purple },
        ["@function.method.call.go"] = { fg = gruvbox.palette.bright_purple },
        ["@variable.go"] = { fg = gruvbox.palette.bright_blue },
        ["@type.go"] = { fg = gruvbox.palette.light1 },
        ["@type.definition.go"] = { fg = gruvbox.palette.light1 },
        ["@function.call.go"] = { fg = gruvbox.palette.light1 },
        ["@variable.member.go"] = { fg = gruvbox.palette.light1 },
  },
  dim_inactive = false,
  transparent_mode = false,
})

vim.cmd[[colorscheme gruvbox]]
