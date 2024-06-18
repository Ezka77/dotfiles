-- install codelldb with :MasonInstall codelldb
-- configure nvim-dap (codelldb)
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
      command = "codelldb",
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }
  dap.adapters.gdb = {
    id = "gdb",
    type = "executable",
    command = "gdb",
    args = { "--quiet", "--interpreter=dap" }
  }
  dap.configurations.cpp = {
    -- GDB
    {
      name = 'Run executable (GDB)',
      type = 'gdb',
      request = 'launch',
      -- This requires special handling of 'run_last', see
      -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
      program = function()
        local path = vim.fn.input({
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        })

        return (path and path ~= '') and path or dap.ABORT
      end,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
      console = "integratedTerminal"
    },
    {
      name = 'Run executable with arguments (GDB)',
      type = 'gdb',
      request = 'launch',
      -- This requires special handling of 'run_last', see
      -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
      program = function()
        local path = vim.fn.input({
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        })

        return (path and path ~= '') and path or dap.ABORT
      end,
      args = function()
        local args_str = vim.fn.input({
          prompt = 'Arguments: ',
        })
        return vim.split(args_str, ' +')
      end,

    },
    {
      name = 'Attach to process (GDB)',
      type = 'gdb',
      request = 'attach',
      processId = require('dap.utils').pick_process,
    },
    -- CODELLDB
    {
      name = "Run executable (CODELLDB)",
      type = "codelldb",
      request = "launch",
      program = function()
        local path = vim.fn.input({
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        })

        return (path and path ~= '') and path or dap.ABORT
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
    {
      name = "Run executable with args (CODELLDB)",
      type = "codelldb",
      request = "launch",
      program = function()
        local path = vim.fn.input({
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        })

        return (path and path ~= '') and path or dap.ABORT
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = function()
        local args_str = vim.fn.input({
          prompt = 'Arguments: ',
        })
        return vim.split(args_str, ' +')
      end,
    },
  }

  dap.configurations.c = dap.configurations.cpp
end
