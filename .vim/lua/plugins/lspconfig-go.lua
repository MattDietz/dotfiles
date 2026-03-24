return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
    servers = {
      settings = {
        gopls = {
          gofumpt = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          diagnostics = {
            maxDiagnosticsPerFile = 50,
          },
          diagnosticsDelay = "500ms",
        },
      },
    },
  },
}
