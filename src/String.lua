local String = {}

function String.split(s, sep)
  sep = type(sep) == 'string' and sep or '%s'

  local parts = {}

  for match in s:gmatch("([^"..sep.."]+)") do
    table.insert(parts, match)
  end

  return parts
end

return setmetatable(String, {
  __call = function(self, s)

    return setmetatable({}, {
      __index = function(self, k)
        if type(k) == 'number' then
          -- TODO: char index
        else
          return String[k]
        end
      end,
    })
  end,
})
