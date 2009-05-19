module SimpleRouter
  class Routes < Array

    def add(*args, &action)
      self << Route.new(*args, &action)
    end

    def match(verb, path)
      none = [nil, nil]
      return none if self.empty?

      verb = verb.to_s.downcase.strip.to_sym

      routes = self.select {|route| route.verb == verb }
      paths  = routes.map  {|route| route.path }

      path, vars = SimpleRouter.engine.match(path, paths)
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
