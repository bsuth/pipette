local flags = require '_flags'

return setmetatable({}, {
  __call = function(self, f, ...)
    if type(f) ~= 'function' then
      error('unsafe(f, ...) => f must be a function')
    end

    flags.UNSAFE = true
    local status, pcallresult = pcall(f(...))
    flags.UNSAFE = false

    if not status then
      error('unsafe(f, ...) => error('..err..')')
    else
      return pcallresult
    end
  end,
})
