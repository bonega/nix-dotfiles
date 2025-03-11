return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              targetDir = "target/rust-analyzer",
              allFeatures = true,
              features = "all",
            },

            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = {},
              },
            },
            check = {
              -- features = "all",
              command = "check",
            },
            diagnostics = {
              disabled = { "inactive-code" },
            },
          },
        },
      },
    },
  },
}
