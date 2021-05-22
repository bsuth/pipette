return setmetatable({}, {
  __call = function(self, value)
    return type(value) == 'table' and value.__type or type(value)
  end,
})
