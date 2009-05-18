require 'test/test_helper'

class App
  include SimpleRouter::DSL
end

class DslTest < Test::Unit::TestCase

  def setup
    App.routes.clear
  end

  ## API

  test "provides action verb methods" do
    App.get(   '/foo') {}
    App.post(  '/foo') {}
    App.put(   '/foo') {}
    App.delete('/foo') {}

    App.routes.size.should be(4)
  end

  test "provides routes object" do
    App.respond_to?(:routes).should be(true)
    App.routes.should be_kind_of(SimpleRouter::Routes)
  end

  ## matching

  test "matching routes" do
    App.get('/foo') { 'foo' }
    App.get('/bar') { 'bar' }

    App.routes.match(:get, '/foo').should_not  be( nil )
    App.routes.match(:get, '/foo').action.call.should be('foo')
  end
end
