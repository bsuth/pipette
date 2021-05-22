local flags = require '_flags'
local unsafe = require 'unsafe'
local Array = require 'Array'

return setmetatable({}, {
  __call = function(self, value)
    if value.__type ~= nil then
      return value.__type
    else
      return type(value)
    end
  end,
})
