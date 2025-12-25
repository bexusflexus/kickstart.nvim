return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",          -- REQUIRED for dap-ui
      "rcarriga/nvim-dap-ui",           -- Debugger UI
      "theHamsta/nvim-dap-virtual-text" -- Inline variable text
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      ---------------------------------------------------------------------------
      -- UI Setup
      ---------------------------------------------------------------------------
      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      -- Auto open/close debugger UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      ---------------------------------------------------------------------------
      -- LLDB Adapter (Fedora / Linux)
      ---------------------------------------------------------------------------
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-dap",
        name = "lldb"
      }

      ---------------------------------------------------------------------------
      -- AUTO-DETECT NEWEST EXECUTABLE IN ./build
      ---------------------------------------------------------------------------
      local function detect_latest_build_artifact()
        local cwd = vim.fn.getcwd()
        local build_dir = cwd .. "/build"

        -- Find executable files in root of build/
        local cmd = 'find "' .. build_dir .. '" -maxdepth 1 -type f -perm -111 2>/dev/null'
        local handle = io.popen(cmd)
        if not handle then
          return nil
        end

        local executables = {}
        for file in handle:lines() do
          table.insert(executables, file)
        end
        handle:close()

        if #executables == 0 then
          return nil
        end

        -- Sort by modification time (newest first)
        table.sort(executables, function(a, b)
          return vim.fn.getftime(a) > vim.fn.getftime(b)
        end)

        return executables[0 + 1]  -- Lua uses 1-based indexing
      end

      ---------------------------------------------------------------------------
      -- Debug Configuration for C++ / C / Rust
      ---------------------------------------------------------------------------
      dap.configurations.cpp = {
        {
          name = "Launch C++ Program",
          type = "lldb",
          request = "launch",

          program = function()
            -- 1) Try auto-detect latest build artifact
            local detected = detect_latest_build_artifact()
            if detected then
              print("📌 Auto-detected executable: " .. detected)
              return detected
            end

            -- 2) Fallback to manual prompt
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,

          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      ---------------------------------------------------------------------------
      -- KEYMAPS (Debugging Controls)
      ---------------------------------------------------------------------------
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue / Start" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP Conditional Breakpoint" })

      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
    end,
  },
}
