local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local command_resolver = require("null-ls.helpers.command_resolver")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({ 
      -- the following looks for prettier in node_modules/.bin, then tries to find a global prettier executable:
      dynamic_command = function(params)
        return command_resolver.from_node_modules(params)
          or vim.fn.executable(params.command) == 1 and params.command
      end,
      filetypes = { "html", "json", "yaml", "markdown" }
    }),
    formatting.eslint.with({
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
      prefer_local = "node_modules/.bin",
      args = { "--fix-dry-run", "--fix-type problem", "--format", "JSON", "--stdin", "--stdin-filename", "$FILENAME" },
      condition = function(utils)
        return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
      end,
    }),
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua.with({
      condition = function(utils)
        return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
      end,
    }),
    -- diagnostics.flake8
  },
})
