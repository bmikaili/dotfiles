return {
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup({
        openai_api_key = { "op", "read", "op://private/OPENAIAPI/credential", "--no-newline" },
      })
    end,
  },
}
