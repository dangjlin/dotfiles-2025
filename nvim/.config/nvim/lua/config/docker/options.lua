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
