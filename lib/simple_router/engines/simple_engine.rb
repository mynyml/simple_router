module SimpleRouter
  module Engines
    class SimpleEngine #:nodoc:

      # Finds a route definition that matches a path
      #
      # ===== Arguments
      # * path: actual path to match (e.g. ENV['PATH_INFO'])
      # * routes: array of 'routes', where each route is composed of [pattern, options]. If route isn't an array, an empty options hash is assumed
      #
      # Currently, this engine implementation ignores route options.
      #
      # ===== Returns
      # Array of two elements:
      #
      # * index 0: first matching route
      # * index 1: array of values for the matched route's variables (in the order they were specified in the route)
      #
      # ===== Examples
      #
      #   SimpleEngine.match('/foo', ['/', '/foo', '/bar/baz'])   #=> ['/foo', []]
      #   SimpleEngine.match('/80/07/01', ['/:year/:month/:day']) #=> ['/foo', ['80', '07', '01']]
      #
      def self.match(path, routes)
        patterns = routes.map {|route| Pattern.new(Array(route).first) }

        patterns.each do |pattern|
          return [pattern.to_path, pattern.vars] if pattern.match(path)
        end

        [nil, []]
      end
    end

    class Pattern < Array #:nodoc:
      def initialize(signature)
        push(split_path(signature)).flatten!
      end

      def match(path)
        @path = split_path(path)
        size_match? && static_match?
      end

      def variables
        _vars = []
        each_with_index do |part,i|
          _vars << @path[i] if part[0] == ?:
        end
        _vars
      end
      alias :vars :variables

      def to_path
        '/' + join('/')
      end

      private
        def size_match?
          @path.size == self.size
        end

        def static_match?
          each_with_index do |part,i|
            return false unless part[0] == ?: || @path[i] == part
          end
          true
        end

        def split_path(path)
          path.split('/').reject {|part| part.empty? }
        end
    end
  end
end
