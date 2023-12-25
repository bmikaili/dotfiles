local cachedConfig = nil
local searchedForConfig = false

local function find_config()
  if searchedForConfig then
    return cachedConfig
  end

  -- find .swiftlint.yml config file in the working directory
  -- could be simplified if you keep it always in the root directory
  local swiftlintConfigs = vim.fn.systemlist({
    "find",
    vim.fn.getcwd(),
    "-maxdepth",
    "2", -- if you need you can set higher number
    "-iname",
    ".swiftlint.yml",
    "-not",
    "-path",
    "*/.*/*",
  })
  searchedForConfig = true

  if vim.v.shell_error ~= 0 then
    return nil
  end

  table.sort(swiftlintConfigs, function(a, b)
    return a ~= "" and #a < #b
  end)

  if swiftlintConfigs[1] then
    cachedConfig = string.match(swiftlintConfigs[1], "^%s*(.-)%s*$")
  end

  return cachedConfig
end

local function setup_swiftlint()
  local lint = require("lint")
  local pattern = "[^:]+:(%d+):(%d+): (%w+): (.+)"
  local groups = { "lnum", "col", "severity", "message" }
  local defaults = { ["source"] = "swiftlint" }
  local severity_map = {
    ["error"] = vim.diagnostic.severity.ERROR,
    ["warning"] = vim.diagnostic.severity.WARN,
  }

  lint.linters.swiftlint = {
    cmd = "swiftlint",
    stdin = false,
    args = {
      "lint",
      "--force-exclude",
      "--use-alternative-excluding",
      "--config",
      function()
        return find_config() or os.getenv("HOME") .. "/.config/nvim/.swiftlint.yml"
      end,
    },
    stream = "stdout",
    ignore_exitcode = true,
    parser = require("lint.parser").from_pattern(pattern, groups, severity_map, defaults),
  }
end

return {
  "mfussenegger/nvim-lint",
  event = "LazyFile",
  opts = {
    -- Event to trigger linters
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      fish = { "fish" },
      swift = { "swiftlint" },
      -- Use the "*" filetype to run linters on all filetypes.
      -- ['*'] = { 'global linter' },
      -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
      -- ['_'] = { 'fallback linter' },
    },
    -- LazyVim extension to easily override linter options
    -- or add custom linters.
    ---@type table<string,table>
    linters = {
      -- -- Example of using selene only when a selene.toml file is present
      -- selene = {
      --   -- `condition` is another LazyVim extension that allows you to
      --   -- dynamically enable/disable linters based on the context.
      --   condition = function(ctx)
      --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
    },
  },
  config = function(_, opts)
    local Util = require("lazyvim.util")

    local M = {}

    local lint = require("lint")
    setup_swiftlint()
    for name, linter in pairs(opts.linters) do
      if type(linter) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
      else
        lint.linters[name] = linter
      end
    end
    lint.linters_by_ft = opts.linters_by_ft

    function M.debounce(ms, fn)
      local timer = vim.loop.new_timer()
      return function(...)
        local argv = { ... }
        timer:start(ms, 0, function()
          timer:stop()
          vim.schedule_wrap(fn)(unpack(argv))
        end)
      end
    end

    function M.lint()
      -- Use nvim-lint's logic first:
      -- * checks if linters exist for the full filetype first
      -- * otherwise will split filetype by "." and add all those linters
      -- * this differs from conform.nvim which only uses the first filetype that has a formatter
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)

      -- Add fallback linters.
      if #names == 0 then
        vim.list_extend(names, lint.linters_by_ft["_"] or {})
      end

      -- Add global linters.
      vim.list_extend(names, lint.linters_by_ft["*"] or {})

      -- Filter out linters that don't exist or don't match the condition.
      local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
      names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if not linter then
          Util.warn("Linter not found: " .. name, { title = "nvim-lint" })
        end
        return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
      end, names)

      -- Run linters.
      if #names > 0 then
        lint.try_lint(names)
      end
    end

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = M.debounce(100, M.lint),
    })
  end,
}
