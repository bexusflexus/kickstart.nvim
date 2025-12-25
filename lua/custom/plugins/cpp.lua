return {
  -- Clangd Extensions: better inline hints, memory, type info
  {
    "p00f/clangd_extensions.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("clangd_extensions").setup {
        inlay_hints = {
          inline = vim.fn.has("nvim-0.10") == 1,
          only_current_line = false,
          show_parameter_hints = true,
        },
      }
      -- ❗ DO NOT add telescope.load_extension("clangd_extensions")
      --    (this plugin does NOT ship a telescope extension)
    end,
  },

  -- Override Kickstart's LSP behavior to use SYSTEM clangd
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=LLVM",
          },
          init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
          },
        },
      },
    },
  },

  -- Better formatting (clang-format)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cpp = { "clang_format" },
        c = { "clang_format" },
      },
    },
  },

  -- Trouble: improved diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      use_diagnostic_signs = true,
    },
  },
}
