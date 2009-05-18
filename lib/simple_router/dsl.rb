module SimpleRouter

  # Mixin that provides a Sinatra-line DSL frontend to the routing engine
  # backend.
  #
  # Meant to be minimal, simple and as magic-free as possible.
  # When mixed in, only adds 5 class methods (#get, #post, #put, #delete and #routes).
  #
  # ==== Examples
  # # simple rack app
  #
  # class App
  #   include SimpleRouter::DSL
  #
  #   get '/' do
  #     'home'
  #   end
  #
  #   get '/users/:id' do |id|
  #   end
  #
  #   put '/:foo/:bar' do |foo, bar, *params|
  #   end
  #
  #   def call(env)
  #     request = Rack::Request.new(env)
  #
  #     verb = request.request_method
  #     path = Rack::Utils.unescape(request.path_info)
  #
  #     action = self.class.routes.match(verb, path).action
  #     action.nil? ? [404, {}, []] : [200, {}, [action.call]]
  #   end
  # end
  #
  # ==== Notes
  # Because the DSL is a simple mixin, it can be used in any class (i.e. not
  # necessarily a rack app).
  #
  module DSL
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        @routes = Routes.new
      end
    end

    module ClassMethods
      attr_reader :routes

      def get(   path, opts={}, &block) routes.add(:get,    path, opts, &block) end
      def post(  path, opts={}, &block) routes.add(:post,   path, opts, &block) end
      def put(   path, opts={}, &block) routes.add(:put,    path, opts, &block) end
      def delete(path, opts={}, &block) routes.add(:delete, path, opts, &block) end
    end
  end
end
