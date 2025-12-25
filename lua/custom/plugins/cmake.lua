return {
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "cmake" },
    dependencies = { "mfussenegger/nvim-dap" },

    config = function()
      require("cmake-tools").setup {
        cmake_command = "cmake",
        cmake_build_directory = "build",
        cmake_build_directory_prefix = "",
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },

        cmake_build_args = {},
        cmake_console_size = 15,
        cmake_console_position = "bottom",

        --- FIX: Tell CMakeTools to use your LLDB adapter instead of `codelldb`
        cmake_dap_configuration = {
          name = "CMake Debug",
          type = "lldb",     -- MUST match dap.adapters.lldb in dap.lua
          request = "launch",
        },

        --- Optional: Search for CMakeLists in parent folders
        cmake_search_prefer_top_level = true,
      }

      -- Keymaps
      vim.keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<cr>",
        { desc = "CMake: Configure" })

      vim.keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<cr>",
        { desc = "CMake: Build" })

      vim.keymap.set("n", "<leader>cr", "<cmd>CMakeRun<cr>",
        { desc = "CMake: Run executable" })

      vim.keymap.set("n", "<leader>cd", "<cmd>CMakeDebug<cr>",
        { desc = "CMake: Debug executable" })
    end,
  },
}
