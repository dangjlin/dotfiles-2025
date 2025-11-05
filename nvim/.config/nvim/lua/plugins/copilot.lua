-- ============================================================================
-- copilot.lua - GitHub Copilot Configuration
-- ============================================================================
-- Configures GitHub Copilot AI code completion:
-- - github/copilot.vim: Official GitHub Copilot plugin
-- - Lazy load: Only loads when entering Insert mode
-- - Accept: <C-J> to accept suggestion (instead of Tab)
-- - Navigate: <Right> for next, <Left> for previous suggestion
-- - Tab is preserved for nvim-cmp completion
-- ============================================================================

return {
  "github/copilot.vim",
  event = "InsertEnter", -- Load Copilot only when entering Insert mode
  config = function()
    print("Copilot plugin start!") -- Debugging print

    -- Debug: Check if Node.js is available
    -- local node_check = vim.fn.system("which node")
    -- print("Node.js path: " .. node_check)

    -- local node_version = vim.fn.system("node --version 2>&1")
    -- print("Node.js version: " .. node_version)

    -- Debug: Check Copilot plugin path
    -- local copilot_path = vim.fn.stdpath("data") .. "/lazy/copilot.vim"
    -- print("Copilot path: " .. copilot_path)
    -- print("Copilot exists: " .. tostring(vim.fn.isdirectory(copilot_path) == 1))

    vim.cmd("Copilot enable")
    -- Remap accept tab to ctrl + j because auto complete words has been set to tab
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false
    })
    vim.g.copilot_no_tab_map = true
    -- Remap `<Right>` to go to the next Copilot suggestion
    vim.api.nvim_set_keymap("i", "<Right>", "<Plug>(copilot-next)", { silent = true, noremap = false })
    -- Optional: Use `<Left>` to cycle backward
    vim.api.nvim_set_keymap("i", "<Left>", "<Plug>(copilot-previous)", { silent = true, noremap = false })

    vim.cmd("Copilot status")
    -- print("Copilot plugin loaded!") -- Debugging print
  end
}
