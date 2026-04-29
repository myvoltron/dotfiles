return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          typescript = {
            -- tsdk를 동적으로 결정
            tsdk = (function()
              local util = require("lspconfig.util")
              local root_dir = util.root_pattern("package.json")(vim.fn.getcwd())
              if not root_dir then
                return nil
              end

              -- 1. Yarn Berry(PnP) 환경 체크
              -- .yarn/sdks 디렉토리가 있고 yarn.lock이 있는 경우
              if vim.uv.fs_stat(root_dir .. "/.yarn/sdks") then
                return ".yarn/sdks/typescript/lib"
              end

              -- 2. 표준 node_modules 환경 체크 (npm, pnpm, yarn classic)
              if vim.uv.fs_stat(root_dir .. "/.yarn/sdks") then
                return "node_modules/typescript/lib"
              end

              return nil
            end)(),
          },
          -- vtsls에게 현재 워크스페이스의 tsdk를 우선 사용하라고 명시적으로 알려줌
          vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
        },
      },
    },
  },
}
