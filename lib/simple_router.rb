module SimpleRouter
  class << self
    attr_accessor :engine
    def engine() super || Engines::SimpleEngine end
  end

  autoload :DSL,    'simple_router/dsl'
  autoload :Routes, 'simple_router/routes'

  module Engines
    autoload :SimpleEngine, 'simple_router/engines/simple_engine'
  end
end
