local _ = require('ldash')

-- -----------------------------------------------------------------------------
-- Iterators
-- -----------------------------------------------------------------------------

describe('Iterators', function()
  test('pairs', function()
    assert.are.equal(1, 1)
  end)

  test('kpairs', function()
    assert.are.equal(1, 1)
  end)

  test('ipairs', function()
    assert.are.equal(1, 1)
  end)
end)

-- -----------------------------------------------------------------------------
-- ipairs
-- -----------------------------------------------------------------------------

describe('ipairs', function()
  test('insert', function()
    assert.are.same({ 1, 2, 3 }, _.insert({ 1, 2 }, 3))
    assert.are.same({ 3, 4, 1, 2 }, _.insert({ 1, 2 }, 1, 3, 4))
    assert.are.same({ 1, 2, 3, 4 }, _.insert({ 1, 2 }, 3, 3, 4))
    assert.are.same({ 1, 3, 4, 2 }, _.insert({ 1, 2 }, -1, 3, 4))
    assert.are.same({ 4, 1, 2, 3 }, _.insert({ 1, 2, 3 }, -3, 4))
  end)

  test('remove', function()
    local t = { 1, 2, 3 }
    assert.are.equal(3, _.remove(t))
    assert.are.same({ 1, 2 }, t)

    local t = { 3, 4, 1, 2 }
    local a, b = _.remove(t, 1, 2)
    assert.are.equal(a, 3)
    assert.are.equal(b, 4)
    assert.are.same({ 1, 2 }, t)

    local t = { 3, 4, 1, 2 }
    local a, b = _.remove(t, 4, 2)
    assert.are.equal(a, 2)
    assert.are.is_nil(b)
    assert.are.same({ 3, 4, 1 }, t)
  end)

  test('join', function()
    assert.are.equal('abc', _.join({ 'a', 'b', 'c' }))
    assert.are.equal('a,b,c', _.join({ 'a', 'b', 'c' }, ','))
  end)

  test('slice', function()
    assert.are.same({ 2, 3 }, _.slice({ 1, 2, 3, 4 }, 2, 3))
    assert.are.same({ 2, 3, 4 }, _.slice({ 1, 2, 3, 4 }, 2))
    assert.are.same({ 2, 3, 4 }, _.slice({ 1, 2, 3, 4 }, -3))
    assert.are.same({ 1, 2, 3 }, _.slice({ 1, 2, 3, 4 }, -4, -2))
  end)
end)

-- -----------------------------------------------------------------------------
-- kpairs
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- pairs
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Strings
-- -----------------------------------------------------------------------------
