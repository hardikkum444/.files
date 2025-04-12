local opts = { noremap = true, silent = true }

-- Opening netrw
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- splitting screen
vim.keymap.set("n", "ss", ":split<Return>", opts)
vim.keymap.set("n", "sv", ":vsplit<Return>", opts)

-- removing the highlights
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", opts)
