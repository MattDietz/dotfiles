return {
  -- Window with buffer text overview, scrollbar and highlights
  {
    "nvim-mini/mini.map",
    event = "LazyFile",
    keys = {
      { "<Leader>m", "<cmd>lua MiniMap.toggle()<CR>", desc = "Mini map" },
    },
    opts = function()
      local minimap = require("mini.map")
      vim.api.nvim_set_hl(0, "MyGitSignsAdd", { fg = "#008000" }) -- A darker green for additions
      vim.api.nvim_set_hl(0, "MyGitSignsChange", { fg = "#FFA500" }) -- Orange for changes (more visible than light green)
      vim.api.nvim_set_hl(0, "MyGitSignsDelete", { fg = "#FF0000" }) -- Red for deletions

      return {
        -- See: `:h MiniMap.gen_integration`
        -- If enabled, increase (or remove) width setting.
        hl_groups = {},
        integrations = {
          -- 	minimap.gen_integration.diagnostic(),
          -- 	minimap.gen_integration.builtin_search(),
          minimap.gen_integration.gitsigns({
            add = "MyGitSignsAdd",
            change = "MyGitSignsChange",
            delete = "MyGitSignsDelete",
          }),
        },
        --symbols = {
        --  scroll_line = "⎕", -- '⎕', '█', '🮚', '▶'
        --  scroll_view = "┊", -- '⎮', '╎', '┋', '┊'
        --},
        window = {
          show_integration_count = false,
          width = 4,
          winblend = 40,
        },
      }
    end,
    config = function(_, opts)
      local minimap = require("mini.map")
      minimap.setup(opts)
      minimap.open()
    end,
  },
}
