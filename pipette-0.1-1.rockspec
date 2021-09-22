package = 'pipette'
version = '0.1-1'

source = {
   url = 'git://github.com/bsuth/pipette',
   branch = 'master',
}

description = {
  summary = 'summary', -- TODO
  detailed = [[
      This is an example for the LuaRocks tutorial.
      Here we would put a detailed, typically
      paragraph-long description.
   ]], -- TODO
  homepage = 'https://bsuth.github.io/pipette',
  license = 'MIT',
}

dependencies = {
  'lua >= 5.1, <= 5.4',
}

build = {
  type = 'builtin',
  modules = {
    ['S'] = 'pipette/S.lua',
    ['T'] = 'pipette/T.lua',
  },
}
