return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint_cli2" },
    },
    linters = {
      markdownlint_cli2 = {
        cmd = "markdownlint-cli2",
        stdin = true,
        args = { "--disable", "MD013", "-" },
        ignore_exitcode = true,
        stream = "stderr",
      },
    },
  },
}
