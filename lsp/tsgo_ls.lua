---@brief
---
--- https://github.com/microsoft/typescript-go
---
--- `tsgo`, aka `typescript-go`, is a native implementation of TypeScript in Go.
--- It aims to provide the same functionality as TypeScript but with significantly improved performance.
---
--- TypeScript-Go can be installed via npm:
--- ```sh
--- npm install @typescript/native-preview
--- ```
---
--- After installation, you can use the `tsgo` command as you would use `tsc`.
---
--- To configure typescript-go, add a
--- [`tsconfig.json`](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html) or
--- [`jsconfig.json`](https://code.visualstudio.com/docs/languages/jsconfig) to the root of your
--- project, just like with regular TypeScript.
---
--- TypeScript-Go provides the following improvements over standard TypeScript:
--- - Drastically improved editor startup
--- - Up to 10x faster build times
--- - Substantially reduced memory usage
---
--- NOTE: TypeScript-Go is still in development and may not have complete feature parity with TypeScript.
--- For up-to-date information on what features are supported, refer to the GitHub repository.

return {
  init_options = { hostInfo = 'neovim' },
  cmd = { 'tsgo', '--lsp', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  handlers = {
    -- handle rename request for certain code actions like extracting functions / types
    ['_typescript.rename'] = function(_, result, ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      vim.lsp.util.show_document({
        uri = result.textDocument.uri,
        range = {
          start = result.position,
          ['end'] = result.position,
        },
      }, client.offset_encoding)
      vim.lsp.buf.rename()
      return vim.NIL
    end,
  },
  on_attach = function(client)
    -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
    vim.api.nvim_buf_create_user_command(0, 'LspTypescriptSourceAction', function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.')
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action({
        context = {
          only = source_actions,
        },
      })
    end, {})
  end,
}
