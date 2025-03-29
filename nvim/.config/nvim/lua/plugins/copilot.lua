return {
  "github/copilot.vim",
  event = "InsertEnter", -- Load Copilot only when entering Insert mode
  config = function()
    print("Copilot plugin loaded!") -- Debugging print
    vim.cmd("Copilot enable")
  end
}
