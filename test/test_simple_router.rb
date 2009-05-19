require 'test/test_helper'

class App
  include SimpleRouter::DSL
end

class SimpleRouterTest < Test::Unit::TestCase

  def setup
    SimpleRouter.engine = nil
  end

  ## engine

  test "default engine" do
    SimpleRouter.engine.name.split('::').last.should be('SimpleEngine')
  end

  test "custom engine" do
    SimpleRouter.engine = ::Object
    SimpleRouter.engine.name.should be('Object')
  end
end
