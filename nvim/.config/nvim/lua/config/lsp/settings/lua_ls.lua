-- ============================================================================
-- lua_ls.lua - Lua Language Server Settings
-- ============================================================================
-- Configures lua_ls (Lua Language Server) with:
-- - Diagnostics: Recognize "vim" and "use" as global variables
-- - Workspace: Include Neovim runtime and config directories in library
-- - Prevents false warnings for Neovim API usage (vim.*, etc.)
-- ============================================================================

return {
  settings = {

    Lua = {
      diagnostics = {
        globals = { "vim", "use" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}
