local path = {
  separator = '/',
}

function path.dirname(path)
  local parts = split(path, '/')
  return join(slice(parts, 0, #parts - 1), '/')
end

function path.basename(path)
  local parts = split(path, '/')
  return parts[#parts]
end

function path.ext(path)
  local basename = basename(path)
end

return path
