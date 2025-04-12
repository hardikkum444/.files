local gruvbox = require("gruvbox")
require("gruvbox").setup({
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = false,
  italic = {
    strings = false,
    emphasis = false, comments = false,
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
        ["@method"] = { fg = gruvbox.palette.bright_purple },
        ["@lsp.type.method"] = { fg = gruvbox.palette.bright_purple },
        ["@function"] = { fg = gruvbox.palette.bright_purple },
        ["@function.method"] = { fg = gruvbox.palette.bright_purple },
        ["@variable.go"] = { fg = gruvbox.palette.bright_blue },
        ["@type.go"] = { fg = gruvbox.palette.light1 },
        ["@type.definition.go"] = { fg = gruvbox.palette.light1 },
        ["@function.call.go"] = { fg = gruvbox.palette.light1 },
        ["@variable.member.go"] = { fg = gruvbox.palette.light1 },
        ["@operator"] = { fg = "#A0DFA0" },
        ["@punctuation.bracket"] = { fg = gruvbox.palette.bright_purple},
  },
  dim_inactive = false,
  transparent_mode = false,
})

