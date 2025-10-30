local function update_lualine_theme(mode)
  local lualine_theme = mode == "dark" and "github_dark_high_contrast" or "github_light_high_contrast"
  require("lualine").setup({
    options = {
      icons_enabled = false,
      theme = lualine_theme,
      component_separators = "|",
      section_separators = "",
    },
  })
end

return {
  {
    "f-person/auto-dark-mode.nvim",
    config = function()
      local auto_dark_mode = require("auto-dark-mode")
      auto_dark_mode.setup({
        update_interval = 1000,
        set_dark_mode = function()
          -- Set LazyVim colorscheme to GitHub Dark
          vim.g.lazyvim_colorscheme = "github_dark_high_contrast"
          vim.cmd("colorscheme github_dark_high_contrast")
          update_lualine_theme("dark")
        end,
        set_light_mode = function()
          -- Set LazyVim colorscheme to GitHub Light
          vim.g.lazyvim_colorscheme = "github_light_high_contrast"
          vim.cmd("colorscheme github_light_high_contrast")
          update_lualine_theme("light")
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- This will get updated by the auto-dark-mode plugin
      colorscheme = vim.g.lazyvim_colorscheme or "default",
    },
  },
}
