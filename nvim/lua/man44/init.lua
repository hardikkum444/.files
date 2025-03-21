require("man44.remap")
require("man44.set")

-- vim.cmd[[colorscheme solarized-osaka]]
vim.o.background = "dark"
-- vim.cmd[[colorscheme gruvbox]]
-- vim.cmd[[colorscheme rose-pine]]
-- vim.cmd[[colorscheme kanagawa-dragon]]
-- vim.cmd[[colorscheme tokyonight-night]]
-- vim.cmd[[colorscheme github_dark_default]]
-- vim.cmd[[colorscheme github_dark_tritanopia]]
-- vim.cmd[[colorscheme ayu-dark]]

-- Key mapping for Coc.nvim Popup Menu Confirmation
vim.api.nvim_set_keymap('i', '<CR>', [[pumvisible() ? coc#_select_confirm() : "\<CR>"]], { expr = true, noremap = true })

-- Allowing yanking to clipboard
vim.opt.clipboard = 'unnamedplus'

vim.opt.guifont='JetBrains Mono'

-- Going block mode baby
vim.opt.guicursor = "a:noCursor"
-- vim.opt.guicursor = "a:hor20"

-- Highlight yanked text
vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "YankHighlight",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
    end,
})

require("gruvbox").setup({
	contrast = "hard",
	palette_overrides = {
		gray = "#2ea542", -- comments are green and by that I mean GREEN
	}
})
