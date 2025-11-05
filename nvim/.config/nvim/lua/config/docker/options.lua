-- ============================================================================
-- docker/options.lua - Docker-Specific Neovim Options
-- ============================================================================
-- Configures clipboard integration for Docker containers:
-- - Uses socat/netcat to sync clipboard with host machine
-- - Copy: Sends to host.docker.internal:8377 (pbcopy on macOS)
-- - Paste: Receives from host.docker.internal:8378 (pbpaste on macOS)
-- - Requires: sync_docker_clipboard() running on host (see zsh helper)
-- ============================================================================

vim.g.clipboard = {
  name = "socat",
  copy = {
    ["+"] = "nc -N host.docker.internal 8377",
    ["*"] = "nc -N host.docker.internal 8377",
  },
  paste = {
    ["+"] = "nc host.docker.internal 8378",
    ["*"] = "nc host.docker.internal 8378",
  },
  clipboard = 'unnamed',
}
