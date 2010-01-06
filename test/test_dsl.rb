require 'test/test_helper'

class App
  include SimpleRouter::DSL
end

context do

  setup do
    SimpleRouter.engine = SimpleRouter::Engines::SimpleEngine
  end

  teardown do
    App.routes.clear
  end

  ## API

  # provides action verb methods 
  test do
    App.get(   '/foo') {}
    App.post(  '/foo') {}
    App.put(   '/foo') {}
    App.delete('/foo') {}

    App.routes.size.must == 4
  end

  # provides routes object 
  test do
    App.respond_to?(:routes).must == true
    App.routes.must.kind_of?(SimpleRouter::Routes)
  end

  ## matching

  # matching routes 
  test do
    App.get('/foo') { 'foo' }
    App.get('/bar') { 'bar' }

    App.routes.match(:get, '/foo').wont == nil
    App.routes.match(:get, '/foo').action.call.must == 'foo'
  end
end
