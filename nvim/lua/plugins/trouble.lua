local hutch_exclude = {
  "hutch/src/Gql/Starsky/",
  "hutch/submodules/",
  "hutch/node_modules/",
  "hutch/src/Translations.elm",
}

local function should_include(item)
  for _, substr in ipairs(hutch_exclude) do
    if string.find(item.filename, substr, 1, true) then
      return false
    end
  end
  return true
end

return {
  {
    "folke/trouble.nvim",
    opts = {
      filter = function(items)
        return vim.tbl_filter(should_include, items)
      end,
    },
  },
}
