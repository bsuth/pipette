--- A 0-based Array class.
-- @classmod Array

local typeof = require 'luascript/typeof'

--
-- setup
--

local Array = { __type = 'Array' }

--
-- metatable
--

local mt = {
  __index = function(self, k)
    if typeof(k) == 'number' then
      return k < 0
        and self.__values[k + 1 + self:len()]
        or self.__values[k + 1]
    else
      return Array[k]
    end
  end,

  __newindex = function(self, i, v)
    if typeof(i) == 'number' then
      if i < 0 then
        self.__values[i + 1 + self:len()] = v
      else
        self.__values[i + 1] = v
      end
    else
      -- TODO: better error message here
      error('Cannot assign to Array')
    end
  end,

  -- TODO: operations (adding, subtracting arrays)
}

---
-- Return the underlying table.
--
-- @treturn table
function Array:raw()
  return self.__values
end

---
-- Return the total number of elements.
--
-- @tparam any v
-- @treturn number
function Array:len()
  return #self.__values
end

---
-- Add elements at a specified index.
--
-- @tparam number i
-- @tparam any ...
-- @treturn self
function Array:insert(i, ...)
  i = (i < 0 and i + self:len() + 1 or i)

  for k, v in ipairs({...}) do
    table.insert(self.__values, i + k, v)
  end

  return self
end

---
-- Add elements to the end of the array.
--
-- @tparam any ...
-- @treturn self
function Array:push(...)
  return self:insert(-1, ...)
end

---
-- Remove elements from a specified index.
--
-- @tparam number i
-- @tparam number? n
-- @treturn self
function Array:remove(i, n)
  i = (i < 0 and i + self:len() or i) + 1
  n = n or 1

  for j = 1, n do
    table.remove(self.__values, i)
  end

  return self
end

---
-- Remove elements from the end of the array.
--
-- @treturn self
function Array:pop()
  return self:remove(-1)
end

---
-- Call a function for each element.
--
-- @tparam function f
-- @treturn self
function Array:each(f)
  for i = 0, self:len() - 1 do
    f(self[i], i)
  end

  return self
end

---
-- Generate a value using all elements.
--
-- @tparam function f
-- @tparam any accumulator
-- @treturn accumulator
function Array:reduce(f, accumulator)
  self:each(function(v, k)
    accumulator = f(accumulator, v, k)
  end)

  return accumulator
end

---
-- Generate a new array by applying a function to all elements.
--
-- @tparam function f
-- @treturn Array
function Array:map(f)
  return self:reduce(function(mapped, v, k)
    return mapped:push(f(v, k))
  end, Array())
end

---
-- Generate a new array by filtering elements.
--
-- @tparam function f
-- @treturn Array
function Array:filter(f)
  return self:reduce(function(filtered, v, k)
    return f(v, k) and filtered:push(v) or filtered
  end, Array())
end

---
-- Find an element and its index.
--
-- @tparam function | any v
-- @treturn v | nil
-- @treturn number | nil
function Array:find(fv)
  f = typeof(fv) == 'function' and fv or function(v, k)
    return v == fv
  end

  for i = 0, self:len() - 1 do
    if f(self[i], i) then
      return self[i], i
    end
  end

  return nil, nil
end

---
-- Generate a new array from an interval.
--
-- @tparam istart number
-- @treturn iend number | nil
-- @treturn Array
function Array:slice(istart, iend)
  local sliced = Array()

  if iend == nil then
    iend = istart < 0 and 0 or self:len()
  end

  for i = istart, iend - 1 do
    sliced:push(self[i])
  end

  return sliced
end

---
-- Generate a string by concatenating all elements, optionally w/ a separator.
--
-- @tparam string | nil sep
-- @treturn string
function Array:join(sep)
  sep = sep or ''

  return self:reduce(function(joined, v, k)
    return joined..tostring(v)..(k == self:len() - 1 and '' or sep)
  end, '')
end

--
-- return
--

return setmetatable(Array, {
  __call = function(self, t)
    return setmetatable({ __values = t or {}, }, mt)
  end,
})
