require 'test/test_helper'

Engine = SimpleRouter::Engines::SimpleEngine

class SimpleEngineTest < Test::Unit::TestCase

  test "matches static paths" do
    Engine.match('/',    ['/', '/foo']).first.should be('/')
    Engine.match('/foo', ['/', '/foo']).first.should be('/foo')
    Engine.match('/bar', ['/', '/foo']).first.should be(nil)
  end

  test "matches variable paths" do
    path, vars = Engine.match('/80/07', ['/foo', '/:year/:month'])
    path.should be('/:year/:month')
    vars.should be(['80','07'])
  end

  test "matches hybrid paths" do
    path, vars = Engine.match('/archives/80/07', ['/foo', '/archives/:year/:month'])
    path.should be('/archives/:year/:month')
    vars.should be(['80','07'])
  end

  test "ignores leading slash in path" do
    path, vars = Engine.match('archives/80/07', ['/foo', '/archives/:year/:month'])
    path.should be('/archives/:year/:month')
    vars.should be(['80','07'])
  end

  test "no matches" do
    path, vars = Engine.match('/80/07/01', ['/foo', '/:year/:month'])
    path.should be(nil)
    vars.should be([])
  end
end
