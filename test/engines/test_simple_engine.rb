require 'test/test_helper'

Engine = SimpleRouter::Engines::SimpleEngine

class SimpleEngineTest < Test::Unit::TestCase

  test "matches simple paths" do
    Engine.match('/',    ['/', '/foo']).should be('/')
    Engine.match('/foo', ['/', '/foo']).should be('/foo')
    Engine.match('/bar', ['/', '/foo']).should be(nil)
  end
end
