local _ = {}

-- -----------------------------------------------------------------------------
-- Ternary / Null Coalesce
-- -----------------------------------------------------------------------------

setmetatable(_, {
  __call = function(self, a, b, c)
    if a then
      return b
    else
      return c
    end
  end,
})

function _._(a, b)
  if a == nil then
    return b
  else
    return a
  end
end

-- -----------------------------------------------------------------------------
-- Iterators
-- -----------------------------------------------------------------------------

function _.pairs(t)
  return pairs(t)
end

function _.kpairs(t)
  -- TODO
  return ipairs(t)
end

function _.ipairs(t)
  return ipairs(t)
end

-- -----------------------------------------------------------------------------
-- ipairs
-- -----------------------------------------------------------------------------

function _.insert(t, idx, ...)
  local varargs = { ... }

  if #varargs == 0 then
    varargs = { idx }
    idx = #t
  else
    idx = idx < 0 and idx + #t or idx
  end

  for i, v in ipairs(varargs) do
    table.insert(t, idx + (i - 1), v)
  end

  return t
end

function _.remove(t, idx, n)
  local removed = {}

  idx = idx and (idx < 0 and idx + #t or idx) or #t
  n = n or 1

  for i = 1, n do
    _.insert(removed, table.remove(t, idx))
  end

  return unpack(removed)
end

function _.join(t, sep)
  sep = _._(sep, '')
  local joined = ''

  for a, v in _.pairs(t) do
    joined = joined .. tostring(v) .. sep
  end

  return joined:substr(joined:len() - sep:len())
end

function _.slice(t, istart, iend)
  local sliced = {}

  iend = _._(iend, _.(istart < 0, -1, #t))

  for i = istart, iend do
    _.insert(sliced, t[i])
  end

  return sliced
end

-- -----------------------------------------------------------------------------
-- kpairs
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- pairs
-- -----------------------------------------------------------------------------

function _.each(t, f, iter)
  iter = _._(iter, pairs)

  for a, v in iter(t) do
    f(v, a)
  end
end

function _.map(t, f, iter)
  iter = _._(iter, pairs)
  local mapped = {}

  for a, v in iter(t) do
    local mapV, mapA = f(v, a)
    mapped[_._(mapA, _(type(a) == 'number', #mapped, a))] = mapV
  end

  return mapped
end

function _.filter(t, f, iter)
  iter = _._(iter, pairs)
  local filtered = {}

  for a, v in iter(t) do
    if f(v, a) then
      filtered[_(type(a) == 'number', #filtered, a)] = v
    end
  end

  return filtered
end

function _.reduce(t, f, accumulator, iter)
  iter = _._(iter, pairs)

  for a, v in iter(t) do
    accumulator = f(accumulator, v, a)
  end

  return accumulator
end

function _.find(t, f, iter)
  iter = _._(iter, pairs)

  for a, v in iter(t) do
    if f(v, a) then
      return v, a
    end
  end

  return nil, nil
end

-- -----------------------------------------------------------------------------
-- Strings
-- -----------------------------------------------------------------------------

function _.split(s, sep)
  sep = _._(sep, '%s')
  local parts = {}

  for match in s:gmatch("([^"..sep.."]+)") do
    table.insert(parts, match)
  end

  return parts
end

--
-- Return
--

return _
