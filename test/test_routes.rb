require 'test/test_helper'

## Routes
context do
  Routes = SimpleRouter::Routes

  setup do
    @routes = Routes.new
    @action = lambda {}
  end

  # stores route definitions 
  test do
    @routes.add(:get, '/foo', {}, &@action)
    @routes.first.path.must == '/foo'
  end

  ## matching

  # matches a path 
  test do
    @routes.add(:get, '/foo', {}, &@action)
    @routes.add(:get, '/bar', {}, &@action)

    @routes.match(:get, '/bar').wont == nil
    @routes.match(:get, '/bar').path.must == '/bar'
  end

  # returns nil when no route matches 
  test do
    @routes.add(:get, '/foo', {}, &@action)
    @routes.add(:get, '/bar', {}, &@action)

    @routes.match('/baz', :get).must == nil
  end

  # normalizes passed in verb string 
  test do
    @routes.add(:get, '/foo', {}, &@action)
    @routes.add(:get, '/bar', {}, &@action)

    @routes.match('get',  '/bar').path.must == '/bar'
    @routes.match('GET',  '/bar').path.must == '/bar'
    @routes.match(' GET ','/bar').path.must == '/bar'
  end
end

## Route
context do

  # internal API 
  test do
    verb, path, options, action = :get, '/foo', {}, lambda {}

    route = SimpleRouter::Routes::Route.new(verb, path, options, &action)
    route.verb    .must == verb
    route.path    .must == path
    route.options .must == options
    route.action  .must == action
    route.values  .must == nil
  end
end

