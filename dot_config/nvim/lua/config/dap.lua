return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")

    -- C/C++ 디버거 설정 (lldb)
    dap.adapters.lldb = {
      type = "executable",
      command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- lldb-vscode 경로 (macOS는 /opt/homebrew/opt/llvm/bin/lldb-vscode)
      name = "lldb",
      env = {
        LLDB_DEBUGSERVER_LOG = "true", -- LLDB 로그 활성화
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES", -- LLDB에서 TTY 모드 사용
      },
    }

    dap.configurations.c = {
      {
        name = "Launch app",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", "./app", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = true,
      },
    }
    dap.configurations.cpp = dap.configurations.c -- C++도 동일하게 설정
  end,
}
