require 'test/test_helper'

class App
  include SimpleRouter::DSL
end

context do

  setup do
    SimpleRouter.engine = nil
  end

  ## engine

  # default engine
  test do
    SimpleRouter.engine.name.split('::').last.must == 'SimpleEngine'
  end

  # custom engine
  test do
    SimpleRouter.engine = ::Object
    SimpleRouter.engine.name.must == 'Object'
  end
end
