-- ============================================================================
-- util.lua - Utility Plugins
-- ============================================================================
-- Core utility plugins used by other plugins:
-- - plenary.nvim: Lua utility functions library (required by many plugins)
-- - impatient.nvim: Speed up Lua module loading
-- - tidy.nvim: Remove trailing whitespace and blank lines on save
-- ============================================================================

return {
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "lewis6991/impatient.nvim",

  -- Remove spacing
  "McAuleyPenney/tidy.nvim",
}
