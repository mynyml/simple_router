module SimpleRouter
  class Routes < Array

    # routing engine
    attr_accessor :engine

    def engine
      @engine || Engines::SimpleEngine
    end

    def add(*args, &action)
      self << Route.new(*args, &action)
    end

    def match(verb, path)
      none = [nil, nil]
      return none if self.empty?

      routes = self.select {|route| route.verb == verb }
      paths  = routes.map  {|route| route.path }

      path, vars = self.engine.match(path, paths)
      return none if path.nil?

      route = routes.detect {|route| route.path == path }
      [route, vars]
    end

    class Route
      attr_accessor :verb,:path,:options,:action

      def initialize(verb, path, options, &action)
        self.verb    = verb
        self.path    = path
        self.options = options
        self.action  = action
      end
    end
  end
end
