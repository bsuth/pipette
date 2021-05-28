local Array = require 'Array'

function compare_arrays(a1, a2)
  assert.are.equal(a1:len(), a2:len())

  a2:each(function(v, k)
    assert.are.equal(v, a1[k])
  end)
end

describe('Array', function()
  test('Array:__index', function()
    local x = Array({ 9, 8 })

    assert.are.equal(Array()[0], nil)
    assert.are.equal(x[0], 9)
    assert.are.equal(x[1], 8)
    assert.are.equal(x[-1], 8)
    assert.are.equal(x[-2], 9)
    assert.are.equal(x[2], nil)
  end)

  test('Array:len', function()
    assert.are.equal(Array():len(), 0)
    assert.are.equal(Array({}):len(), 0)
    assert.are.equal(Array({ 8 }):len(), 1)
    assert.are.equal(Array({ 4, 6, -3 }):len(), 3)
  end)

  test('Array:insert', function()
    compare_arrays(
      Array({ 4, 3, 7 }):insert(0, 4, 2),
      Array({ 4, 2, 4, 3, 7 })
    )

    compare_arrays(
      Array({ 4, 3, 7 }):insert(1, 4, 2),
      Array({ 4, 4, 2, 3, 7 })
    )

    compare_arrays(
      Array({ 4, 3, 7 }):insert(-2, 4, 2),
      Array({ 4, 3, 4, 2, 7 })
    )
  end)

  test('Array:push', function()
    local x = Array()
    x:push(2)
    assert.are.equal(x:len(), 1)
    x:push(43):push(4, 6, 3)
  end)

  test('Array:remove', function()
    compare_arrays(
      Array({ 4, 3, 7 }):remove(1, 1),
      Array({ 4, 7 })
    )

    compare_arrays(
      Array({ 4, 3, 7, 9, 3 }):remove(2, 2),
      Array({ 4, 3, 3 })
    )

    compare_arrays(
      Array({ 4, 3, 8, 7 }):remove(-2, 2),
      Array({ 4, 3 })
    )
  end)

  test('Array:push', function()
    local x = Array()
    x:push(2)
    assert.are.equal(x:len(), 1)
    x:push(43):push(4, 6, 3)
  end)

  test('Array:each', function()
    local K = 0
    local V = 0

    Array({ 23, 45, 12}):each(function(v, k)
      K = K + k
      V = V + v
    end)

    assert.are.equal(K, 3)
    assert.are.equal(V, 80)
  end)

  test('Array:reduce', function()
    assert.are.equal(
      Array({ 54, 32, 14 }):reduce(function(sum, v, k)
        return sum + v + k
      end, 0),
      103
    )
  end)

  test('Array:map', function()
    compare_arrays(
      Array({ 8, 1, 5 }):map(function(v, k)
        return v + k
      end),
      Array({ 8, 2, 7 })
    )
  end)

  test('Array:filter', function()
    compare_arrays(
      Array({ -1, 4, -19, -2, 9 }):filter(function(v, k)
        return v + k > 0
      end),
      Array({ 4, -2, 9 })
    )
  end)

  test('Array:find', function()
    local v, k

    v, k = Array({ 1, 5, 2 }):find(1)
    assert.are.equal(v, 1)
    assert.are.equal(k, 0)

    v, k = Array({ 1, 5, 2 }):find(4)
    assert.is_nil(v)
    assert.is_nil(k)

    v, k = Array({ -1, 5, 2 }):find(function(v, k)
      return v > 0
    end)

    assert.are.equal(v, 5)
    assert.are.equal(k, 1)

    v, k = Array({ 1, 5, 2 }):find(function(v, k)
      return v < 0
    end)

    assert.is_nil(v)
    assert.is_nil(k)
  end)

  test('Array:slice', function()
    compare_arrays(
      Array({ 4, 9, 1, 8, 5 }):slice(3, 5),
      Array({ 8, 5 })
    )
    compare_arrays(
      Array({ 4, 9, 1, 8, 5 }):slice(1),
      Array({ 9, 1, 8, 5 })
    )
    compare_arrays(
      Array({ 4, 9, 1, 8, 5 }):slice(-3, -1),
      Array({ 1, 8 })
    )
  end)

  test('Array:join', function()
    assert.are.equal(
      Array({ 'hello', 'world' }):join('_'),
      'hello_world'
    )

    assert.are.equal(
      Array({ 'hello', 'world' }):join(),
      'helloworld'
    )
  end)
end)
