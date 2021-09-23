--- Table utilities
-- @module T
local T = {}

--- Create a table from the keys of another table's map elements.
-- @tparam table t the table from which to extract
-- @treturn table the table of keys
function T.keys(t)
  local keys = {}

  for key, value in pairs(t) do
    if type(key) == 'string' then
      table.insert(keys, key)
    end
  end

  return keys
end

--- Create a table from the values of another table's map elements.
-- @tparam table t the table from which to extract
-- @treturn table the table of values
function T.values(t)
  local values = {}

  for key, value in pairs(t) do
    if type(key) == 'string' then
      table.insert(values, value)
    end
  end

  return values
end

--- Invoke a callback over all elements of a table.
-- @tparam table t the table to iterate
-- @tparam function callback callback to invoke. Takes (value, key) as params
-- @treturn table t (for chaining)
function T.each(t, callback)
  for key, value in pairs(t) do
    callback(value, key)
  end

  return t
end

--- Map the elements of a table to different values (and keys).
-- @tparam table t the table to map
-- @tparam function mapper callback to invoke. Takes (value, key) as params and
-- is expected to return at least one value (the mapped value) and optionally a
-- new key.
-- @treturn table the mapped table
function T.map(t, mapper)
  local mapped = {}

  for key, value in pairs(t) do
    local mappedvalue, mappedkey = mapper(value, key)

    if mappedkey ~= nil then
      mapped[mappedkey] = mappedvalue
    elseif type(key) == 'string' then
      mapped[key] = mappedvalue
    else
      table.insert(mapped, mappedvalue)
    end
  end

  return mapped
end

--- Filter the elements of a table.
-- @tparam table t the table to filter
-- @tparam function filterer callback to invoke. Takes (value, key) as params
-- and it expected to return either true (if the key, value pair should be kept)
-- or false (if the key, value pair should be discarded).
-- @treturn table the filtered table
function T.filter(t, filterer)
  local filtered = {}

  for key, value in pairs(t) do
    if filterer(value, key) then
      if type(key) == 'string' then
        filtered[key] = value
      else
        table.insert(filtered, value)
      end
    end
  end

  return filtered
end

--- Reduce the elements of a table to a single value.
-- @tparam table t the table to reduce
-- @tparam func reducer callback to invoke. Takes (reduction, value, key) as
-- params and is expected to return the reduction.
-- @param reduction the reduction's initial value
-- @return the reduction
function T.reduce(t, reducer, reduction)
  for key, value in pairs(t) do
    reduction = reducer(reduction, value, key)
  end

  return reduction
end

--- Create a table from a consecutive subset of another table's array elements.
-- @tparam table t the table from which to extract
-- @tparam[opt=0] number istart starting index of the slice, can be negative
-- @tparam[opt=#t] number iend ending index of the slice, can be negative
-- @treturn table the table slice
function T.slice(t, istart, iend)
  local sliced = {}

  if istart == nil then
    istart = 0
  elseif istart < 0 then
    istart = istart + #t + 1
  end

  if iend == nil then
    iend = #t
  elseif iend < 0 then
    iend = iend + #t + 1
  end

  for i = istart, iend do
    table.insert(sliced, t[i])
  end

  return sliced
end

--- Join the array elements of a table into a string.
-- @tparam table t the table to join
-- @tparam[opt=""] string sep optional separator
-- @treturn string the joined string
function T.join(t, sep)
  sep = sep or ''
  local joined = ''

  for i, v in ipairs(t) do
    joined = joined .. tostring(v) .. (i < #t and sep or '')
  end

  return joined
end

--- Find a (value, key) pair in a table.
-- @tparam table t the table to search
-- @param search if this is a function, the first pair w/
-- `search(value, key) == true` is returned. Otherwise the first pair w/
-- `value === search` is returned. Default returns (nil, nil).
-- @treturn value the found value
-- @treturn key the found key
function T.find(t, search)
  iter = iter or pairs

  if type(search) == 'function' then
    for key, value in pairs(t) do
      if search(value, key) then
        return value, key
      end
    end
  else
    for key, value in pairs(t) do
      if value == search then
        return value, key
      end
    end
  end

  return nil, nil
end

-- -----------------------------------------------------------------------------
-- Unsure Zone
-- -----------------------------------------------------------------------------

function T.has(t, value)
  for i, v in ipairs(t) do
    if v == value then
      return true
    end
  end

  return false
end

function T.combine(...)
  local args = { ... }
  iter = pairs
  local combined = {}

  if type(args[#args]) == 'function' then
    iter = table.remove(args)
  end

  for i, t in ipairs(args) do
    for a, v in iter(t) do
      if type(a) == 'number' then
        table.insert(combined, v)
      else
        combined[a] = v
      end
    end
  end

  return combined
end

function T.insert(t, idx, ...)
  local varargs = { ... }

  if #varargs == 0 then
    varargs = { idx }
    idx = #t + 1
  else
    idx = idx < 0 and idx + #t + 1 or idx
  end

  for i, v in ipairs(varargs) do
    table.insert(t, idx + (i - 1), v)
  end

  return t
end

function T.remove(t, idx, n)
  local removed = {}

  idx = idx and (idx < 0 and idx + #t + 1 or idx) or #t
  n = n or 1

  for i = 1, n do
    T.insert(removed, table.remove(t, idx))
  end

  return unpack(removed)
end

return T
