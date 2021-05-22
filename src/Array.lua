--- A 0-based Array class.
-- @classmod Array

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

---
-- Add an element to the end of the array.
--
-- @tparam any v
-- @treturn self
function Array:push(v)
  table.insert(self.__values, v)
  return self
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
function Array:find(v)
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
-- @treturn iend number
-- @treturn Array
function Array:slice(istart, iend)
  local sliced = Array()

  for i = istart, iend do
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
    return joined .. tostring(t[k]) .. (k == #t and '' or sep)
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
