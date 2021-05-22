local typecheck = require 'typecheck'
local typeof = require 'typeof'

--
-- setup
--

local Array = {
  __type = 'Array',
  __values = {},
}

--
-- metatable
--

local mt = {
  __index = function(self, k)
    if typeof(k) == 'number' then
      if k > #self - 1 or k < -(#self - 1) then
        error('out of bounds access: '..tostring(k))
      elseif k < 0 then
        return self[k + 1 + #self]
      else
        return self[k + 1]
      end
    else
      return Array[k]
    end
  end,

  -- TODO: operations (adding, subtracting arrays)
}

--
-- basics
--

function Array:push(v)
  typecheck(self, Array.__type)
  table.insert(self.__values, v)
  return self
end

function Array:len()
  typecheck(self, Array.__type)
  return #self.__values
end

--
-- iterating
--

function Array:each(f)
  typecheck(self, Array.__type)
  typecheck(f, 'function')

  for k, v in ipairs(self.__values) do
    f(v, k)
  end

  return self
end

function Array:reduce(f, accumulator)
  typecheck(self, Array.__type)
  typecheck(f, 'function')

  self:each(function(v, k)
    accumulator = f(accumulator, v, k)
  end)

  return accumulator
end

function Array:map(f)
  typecheck(self, Array.__type)
  typecheck(f, 'function')

  return self:reduce(function(mapped, v, k)
    return mapped:push(f(v, k))
  end, Array())
end

function Array:filter(f)
  typecheck(self, Array.__type)
  typecheck(f, 'function')

  return self:reduce(function(filtered, v, k)
    return f(v, k) and filtered:push(v) or filtered
  end, Array())
end

--
-- util
--

function Array:find(f)
  typecheck(self, Array.__type)
  typecheck(f, 'function')

  for k, v in ipairs(self.__values) do
    if f(v, k) then
      return v, k
    end
  end

  return nil, nil
end

-- -- TODO: negative indices?
function Array:slice(istart, iend)
  typecheck(self, Array.__type)
  typecheck(istart, 'number')
  typecheck(iend, 'number')

  local sliced = Array()

  for i = istart, iend do
    sliced:push(self.__values[i])
  end

  return sliced
end

function Array:join(sep)
  typecheck(self, Array.__type)
  typecheck(sep, 'string')

  return self:reduce(function(joined, v, k)
    return joined .. tostring(t[k]) .. (k == #t and '' or sep)
  end, '')
end

--
-- return
--

return setmetatable(Array, {
  __call = function(self, t)
    typecheck(t, 'table', 'nil')
    return setmetatable({ __values = t or {}, }, mt)
  end,
})
