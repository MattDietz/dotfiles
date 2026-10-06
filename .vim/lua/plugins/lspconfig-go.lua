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
          analyses = {
            ST1000 = false, -- package docs recommendation. Not needed at Mailgun
            QF1001 = true, -- DeMorgan's Law check
            QF1006 = true, -- TODO: lifting break condition into infinite for loop
            QF1011 = true, -- omit redundant type info
            S1008 = true, -- Simplify boolean returns using if blocks
            S1011 = true, -- single append for slice concat
            S1025 = true, -- Unnecessary Sprintf() usage
            SA1014 = true, -- Non-pointer args to Unmarshal/Decode
            SA1015 = true, -- time.Tick Go1.23 update
            SA1017 = true, -- os.Notify should be buffered channel
            SA1029 = true, -- Context key type hint
            SA4010 = true, -- Append result never used
            SA4017 = true, -- pointless function return discarded
            SA4023 = true, -- interface comparison to nil mistake
            SA4031 = true, -- never-nil == nil check
            SA5000 = true, -- assignment to nil map
            SA5007 = true, -- infinite recursion
            SA5010 = true, -- Impossible type assertion for interfaces
            SA6000 = true, -- Recommend regex.Compile
            SA6001 = true, -- map of bytes optimization
            SA6002 = true, -- sync.Pool allocation check
            SA9001 = true, -- defers don't run in loops when expected
            SA9005 = true, -- Attempt to marshal an un-marshallable object
            SA9008 = true, -- Type assertion else-branch mistake
            ST1003 = true, -- effective package naming
            ST1005 = true, -- error string formatting
            ST1008 = true, -- errors should be returned last in funcs
            ST1013 = true, -- TODO prefer http constants for status codes
            ST1016 = true, -- consistent receiver names
            ST1020 = true, -- exported function documentation convention
            ST1021 = true, -- exported type documentation convention
            ST1023 = true, -- redundant variable type info
            appendclipped = true, -- suggest slices.Concat
            unusedparams = true,
            shadow = true,
            fillstruct = true,
            modernize = true,
            unusedfunc = true,
            hostport = true,
            gofix = true,
            slicesdelete = true, -- recommend slices.Delete over old append trick
            fieldalignment = true, -- TODO may be too noisy but handy
          },
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
