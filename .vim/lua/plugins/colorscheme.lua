return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  {
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd([[colorscheme aura-dark]])
      vim.api.nvim_set_hl(0, "MatchParen", { fg = "#15141b", bg = "#e3b388", bold = true }) -- Previous MatchParen color was setting it to black, effectively disabling it
    end,
  },
  -- Configure LazyVim to load gruvbox
  --{
  --  "LazyVim/LazyVim",
  --  opts = {
  --    colorscheme = "tokyonight-storm",
  --    -- colorscheme = "aura-theme",
  --  },
  --},
}
