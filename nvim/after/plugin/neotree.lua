vim.api.nvim_set_keymap('n', '<leader>n', ':Neotree<CR>', { noremap = true, silent = true })

require("neo-tree").setup({
    window = {
        width = 30,  -- Set the desired width here
        mappings = {
            ["b"] = "close_window",
            ["p"] = "add_directory",
            ["r"] = "rename",
            ["d"] = "delete",
            --["H"] = "toggle_hidden",
            --["a"] = "add_file",
        }
    }
})

