
Summary
-------
Small and simple standalone router, meant for use with Rack applications.

Features
--------
* Familiar Sinatra-like DSL for defining actions
* Modular architecture (see ROUTING ENGINES section)
* No magic
* Low level / Highly flexible
* Simple code

Examples
--------

  class App
    include SimpleRouter::DSL

    get '/' do
      'home'
    end

    get '/archives/:year/:month/:day' do |year, month, day|
      Article.archived.find_by_date(year, month, day)
    end

    def call(env)
      verb, path  = ENV['REQUEST_METHOD'], ENV['PATH_INFO']
      route = self.class.routes.match(verb, path)
      route.nil? ?
        [404, {'Content-Type' => 'text/html'}, '404 page not found'] :
        [200, {'Content-Type' => 'text/html'}, route.action.call(*route.values)]
    end
  end

The SimpleRouter::DSL mixin provides 5 class methods:

  #get, #post, #put, #delete and #routes

The four verb methods allow you to define actions that will match a request for
the verb and route signature it defines.

The #routes method responds to #match and will return the first matching route
(in order they were defined), and the values of the variables defined in the
route signature if any (:year, :month, ...).

Finally, the route returned is a simple object: for the second route in the
example above:

  route.verb    #=> :get
  route.path    #=> '/archives/:year/:month/:day'
  route.action  #=> lambda {|year, month, day| Article.archived.find_by_date(year, month, day) }
  route.values  #=> ['2008', '07', '01'] # after being matched with path '/archives/2008/07/01'

See examples/ directory for executable code examples.

Routing Engines
---------------
By design, the code is seperated in two main components:

  o DSL for defining routes/actions and retrieving requested action block.
  o Routing engine

Different engines can be used by assigning them to the router:

  SimpleRouter.engine = UltraFastEngine

This allows, for instance, a new faster engine to be used by an app without
changes in the top level DSL.

Engines can also allow route definitions to include more (or less!) features.
For example, the built-in SimpleEngine allows route variables and extension
handling. Others could add variable conditions ( :id => Integer ), mime-type
restrictions, etc.

#### Engine Writers

Engines only need to conform to a simple interface. See
lib/simple_router/engines/simple_engine.rb for details.

