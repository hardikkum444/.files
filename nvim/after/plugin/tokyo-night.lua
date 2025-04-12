require("tokyonight").setup({
  style = "night",
  lazy = false,
  priority = 1000,
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    functions = { italic = false },
    variables = { italic = false },
    statements = { italic = false },
    conditionals = { italic = false },
    loops = { italic = false },
    constants = { italic = false },
    numbers = { italic = false },
    operators = { italic = false },
    types = { italic = false },
  },
  on_colors = function(colors)
    colors.comment = "#7E7E7E"
    colors.error = "#ff0000"
    colors.warnings = "#ff0000"
  end,
})

-- Example config in Lua
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
