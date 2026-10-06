return {
  "snacks.nvim",
  opts = {
    indent = {
      enabled = false,
    },
    scroll = {
      enabled = false,
    },
    picker = {
      sources = {
        files = {
          hidden = true,
          exclude = { "*/venv/*", "*/node_modules/*" },
        },
      },
    },
  },
}
