module SimpleRouter
  module Engines
    class SimpleEngine

      # Finds a route definition that matches a path
      #
      # ===== Arguments
      # * path: actual path to match (e.g. ENV['PATH_INFO'])
      # * routes: array of user defined routes
      #
      # ===== Returns
      # Array of two elements:
      #
      # * index 0: first matching route
      # * index 1: array of values for route variables, in the order they were specified
      #
      # ===== Examples
      #
      #   SimpleEngine.match('/foo', ['/', '/foo', '/bar/baz'])   #=> ['/foo', []]
      #   SimpleEngine.match('/80/07/01', ['/:year/:month/:day']) #=> ['/foo', ['80', '07', '01']]
      #
      def self.match(path, routes)
        routes.each do |route|
          return route if route == path
        end
        nil
      end
    end
  end
end
