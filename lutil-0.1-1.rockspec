package = 'lutil'
version = '0.1-1'

source = {
   url = 'git://github.com/bsuth/lutil',
   branch = 'master',
}

description = {
  summary = 'summary', -- TODO
  detailed = [[
      This is an example for the LuaRocks tutorial.
      Here we would put a detailed, typically
      paragraph-long description.
   ]], -- TODO
  homepage = 'https://github.com/bsuth/luascript',
  license = 'MIT',
}

dependencies = {
  'lua >= 5.1, <= 5.4',
  -- If you depend on other rocks, add them here
}

build = {
  type = 'builtin',
  modules = {
    ['lutil'] = 'lutil.lua',
  },
}