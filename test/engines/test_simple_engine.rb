require 'test/test_helper'

Engine = SimpleRouter::Engines::SimpleEngine

class SimpleEngineTest < Test::Unit::TestCase

  test "matches simple paths" do
    Engine.match('/',    ['/', '/foo']).first.should be('/')
    Engine.match('/foo', ['/', '/foo']).first.should be('/foo')
    Engine.match('/bar', ['/', '/foo']).first.should be(nil)
  end
end
