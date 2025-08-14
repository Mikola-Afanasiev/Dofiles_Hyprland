return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
    "tomblind/local-lua-debugger-vscode",
    "jbyuki/one-small-step-for-vimkind",
    "mfussenegger/nluarepl",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- 📦 Получаем путь к poetry python
    local handle = io.popen("poetry env info -p")
    local venv_path = handle:read("*a"):gsub("%s+", "")
    handle:close()
    local python_path = venv_path .. "/bin/python"

    -- 🐍 Настройка Python отладчика
    require("dap-python").setup(python_path)

    -- 📁 Указание конфигурации Python
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch current file",
        program = "${file}",
        pythonPath = function()
          return python_path
        end,
        cwd = vim.fn.getcwd(),
      },
    }

    -- 🔧 Настройка интерфейса и других адаптеров
    dapui.setup()
    require("dap-go").setup()

    dap.adapters["local-lua"] = {
      type = "executable",
      command = "node",
      args = {
        "/absolute/path/to/local-lua-debugger-vscode/extension/debugAdapter.js",
      },
      enrich_config = function(config, on_config)
        if not config["extensionPath"] then
          local c = vim.deepcopy(config)
          c.extensionPath = "/absolute/path/to/local-lua-debugger-vscode/"
          on_config(c)
        else
          on_config(config)
        end
      end,
    }

    -- 📦 DAP UI auto open/close
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- ⌨️ Клавиши
    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dc", dap.continue, {})
  end,
}
