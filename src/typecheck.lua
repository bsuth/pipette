local flags = require '_flags'
local unsafe = require 'unsafe'
local Array = require 'Array'

return setmetatable({}, {
  __call = function(self, value, ...)
    if flags.UNSAFE then return end

    local validtypes = {...}
    local valuetype = type(value)

    for i, v in ipairs(validtypes) do
      if type(v) ~= 'string' then
        error('typecheck(v, ...) => ... must be strings')
      end
    end

    for i, v in ipairs(validtypes) do
      if valuetype == v then
        return
      end
    end

    error(('expected %s, got %s'):format(
      '('..unsafe(Array.join(validtypes, ', '))..')',
      valuetype
    ))
  end,
})
