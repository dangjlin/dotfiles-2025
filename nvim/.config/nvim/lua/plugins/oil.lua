-- ============================================================================
-- oil.lua - Oil File Explorer Configuration
-- ============================================================================
-- Configures Oil file manager plugin:
-- - stevearc/oil.nvim: Edit filesystem like a buffer
-- - Features: Edit files/dirs like text, show hidden files, icon column
-- - Keybindings: "-" opens parent directory, <space>- opens floating window
-- - Not default file explorer (nvim-tree is default)
-- - Alternative to nvim-tree for buffer-like file editing
-- ============================================================================

return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup {
        default_file_explorer = false,
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "<space>-", require("oil").toggle_float)
    end,
  },
}
