local flags = require '_flags'
local Array = require 'Array'
local typeof = require 'typeof'
local unsafe = require 'unsafe'

return setmetatable({}, {
  __call = function(self, value, ...)
    if flags.UNSAFE then return end
    local validtypes = unsafe(Array, ...)

    unsafe(validtypes:each(function(v)
      if typeof(v) ~= 'string' then
        error('typecheck(value, ...) => ... must be strings, got: '..typeof(v))
      end
    end))

    if unsafe(validtypes:find(function(v) return typeof(value) == v end)) then
      return
    end

    error(('expected %s, got %s'):format(
      '('..unsafe(validtypes:join(', '))..')',
      typeof(value)
    ))
  end,
})
