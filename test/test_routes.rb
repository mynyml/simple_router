require 'test/test_helper'

Routes = SimpleRouter::Routes

class RoutesTest < Test::Unit::TestCase

  def setup
    @routes = Routes.new
    @action = lambda {}
  end

  test "stores route definitions" do
    @routes.add(:get, '/foo', {}, &@action)
    @routes.first.path.should be('/foo')
  end

  ## matching

  test "matches a path" do
    @routes.add(:get, '/foo', {}, &@action)
    @routes.add(:get, '/bar', {}, &@action)

    @routes.match(:get, '/bar').should_not  be(nil)
    @routes.match(:get, '/bar').first.path.should be('/bar')
  end

  test "returns nil when no route matches" do
    @routes.add(:get, '/foo', {}, &@action)
    @routes.add(:get, '/bar', {}, &@action)

    @routes.match('/baz', :get).should be([nil,nil])
  end

  ## engine

  test "default engine" do
    @routes.engine.name.split('::').last.should be('SimpleEngine')
  end

  test "custom engine" do
    @routes.engine = ::Object
    @routes.engine.name.should be('Object')
  end
end

class RouteTest < Test::Unit::TestCase

  test "internal API" do
    verb, path, options, action = :get, '/foo', {}, lambda {}

    route = SimpleRouter::Routes::Route.new(verb, path, options, &action)
    route.verb    .should be(verb)
    route.path    .should be(path)
    route.options .should be(options)
    route.action  .should be(action)
  end
end
