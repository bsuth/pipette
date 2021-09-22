--- String Utils
-- @module S
local S = {}

--- Split a string into a table.
-- @tparam string s the string to split
-- @tparam[opt="%s"] string sep the separator on which to split 
-- @treturn table the table of split values
function S.split(s, sep)
  sep = sep or '%s'
  local values = {}

  for match in s:gmatch('([^' .. sep .. ']+)') do
    table.insert(values, match)
  end

  return values
end

return S
