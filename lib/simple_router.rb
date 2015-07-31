module SimpleRouter
  class << self
    attr_accessor :engine_reference
    def engine() self.engine_reference || Engines::SimpleEngine end
    def engine=(value) self.engine_reference=value end
  end

  autoload :DSL,    'simple_router/dsl'
  autoload :Routes, 'simple_router/routes'

  module Engines
    autoload :SimpleEngine, 'simple_router/engines/simple_engine'
  end
end
