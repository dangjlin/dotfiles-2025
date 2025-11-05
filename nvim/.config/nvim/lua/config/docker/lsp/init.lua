-- ============================================================================
-- docker/lsp/init.lua - Docker-Specific LSP Configuration
-- ============================================================================
-- Configures LSP package installation for Docker ARM64 environment:
-- - Packages: lua-language-server, stylua
-- - Platform: linux_arm64_gnu (ARM64 architecture)
-- - Auto-install: Checks if package is installed, installs with correct target
-- - Workaround: Mason doesn't auto-detect ARM64 Docker correctly
-- ============================================================================

local registry = require 'mason-registry'
for _, package_name in ipairs { 'lua-language-server', 'stylua' } do
  local ok, package = pcall(function()
    return registry.get_package(package_name)
  end)
  if ok and (not package:is_installed()) then
    -- Override the installation options
    package:install {
      target = 'linux_arm64_gnu', -- Specify the target platform manually if supported
    }
  end
end
