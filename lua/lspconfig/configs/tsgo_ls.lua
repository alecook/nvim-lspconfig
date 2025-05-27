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

local util = require 'lspconfig.util'

return {
  default_config = {
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
    root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
    single_file_support = true,
  },
}
