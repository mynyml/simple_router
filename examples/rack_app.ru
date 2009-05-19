require 'pathname'
root  =  Pathname(__FILE__).dirname.parent.expand_path
$:.unshift(root.join('lib'))

# run me with:
#   $rackup examples/rack_app.ru
# --------------------------------------------------
require 'rubygems'
require 'simple_router'

class App
  include SimpleRouter::DSL

  get '/' do |params|
    <<-html
    <pre>
      params: #{params.inspect}
    </pre>
    html
  end

  get '/:foo.:type' do |foo, type, params|
    <<-html
    <pre>
      foo: #{foo.inspect}
      type: #{type.inspect}
      params: #{params.inspect}
    </pre>
    html
  end

  def call(env)
    request = Rack::Request.new(env)

    verb = request.request_method.downcase.to_sym
    path = Rack::Utils.unescape(request.path_info)

    route, args = self.class.routes.match(verb, path)
    route.nil? ?
      [404, {'Content-Type' => 'text/html'}, '404 page not found'] :
      [200, {'Content-Type' => 'text/html'}, [route.action.call(*args.push(request.params))]]
  end
end

run App.new
