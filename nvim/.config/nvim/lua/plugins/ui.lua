return {
  -- highlight parenthesis
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      -- rainbow_delimiters, This module contains a number of default definitions
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        }
      }
    end,
  },

  -- CSS #fff
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Indent
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      -- indent_blankline
      local highlight = {
        "CursorColumn",
        "Whitespace",
      }
      require("ibl").setup({
        indent = { highlight = highlight, char = "" },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
        },
        scope = { enabled = false },
      })

    end
  },

  -- Tagbar alternative
  -- Vista, not working, not sure why...
  {
    "liuchengxu/vista.vim",
    config= function()
      vim.g.vista_executive_for = {
        clj = "nvim_lsp",
        cljs = "nvim_lsp",
      }
    end
  }
}
