return {
  {
    "folke/trouble.nvim",
    opts = {
      filter = function(items)
        return vim.tbl_filter(function(item)
          return not (
            string.match(item.filename, "hutch/src/Gql/Starsky/")
            or string.match(item.filename, "hutch/submodules/")
            or string.match(item.filename, "hutch/node_modules/")
            or string.match(item.filename, "hutch/src/Translations.elm")

          )
        end, items)
      end,
    },
  },
}
