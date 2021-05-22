local Array = require 'Array'

describe('Array', function()
  test('Array:len', function()
    assert.are.equal(Array():len(), 0)
    assert.are.equal(Array({}):len(), 0)
    assert.are.equal(Array({8}):len(), 1)
    assert.are.equal(Array({4, 6, -3}):len(), 3)
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

  pending('Array:reduce')
  pending('Array:map')
  pending('Array:filter')
  pending('Array:find')
  pending('Array:slice')
  pending('Array:join')
end)
