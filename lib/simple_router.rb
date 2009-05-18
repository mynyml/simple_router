module SimpleRouter
  autoload :DSL,    'simple_router/dsl'
  autoload :Routes, 'simple_router/routes'

  module Engines
    autoload :SimpleEngine, 'simple_router/engines/simple_engine'
  end
end
