-- ============================================================================
-- init.lua - Neovim Main Entry Point
-- ============================================================================
-- This is the main Neovim configuration entry point that:
-- - Sets the leader key to comma (,)
-- - Loads core configuration modules (options, autocmds, keymaps, lsp)
-- - Initializes Lazy.nvim plugin manager
-- - Detects Docker environment and loads Docker-specific config if needed
-- ============================================================================

vim.g.mapleader = ","
-- vim.g.maplocalleader = " "

require("config.options")
require("config.autocmds")
require("config.lazy")
require("config.keymaps")
require("config.lsp")

local is_docker = vim.fn.filereadable("/.dockerenv") == 1
if is_docker then
  require("config.docker.options")
  require("config.docker.lsp.init")
end
