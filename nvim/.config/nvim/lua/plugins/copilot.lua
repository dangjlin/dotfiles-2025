return {
  "github/copilot.vim",
  event = "InsertEnter", -- Load Copilot only when entering Insert mode
  config = function()
    print("Copilot plugin start!") -- Debugging print
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
    print("Copilot plugin loaded!") -- Debugging print
  end
}
