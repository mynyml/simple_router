Gem::Specification.new do |s|
  s.name                = 'rack-abstract-format'
  s.version             = "0.9.8"
  s.summary             = "Rack middleware that abstracts format (extension) away from the path (into env)"
  s.description         = "Rack middleware that abstracts format (extension) away from the path (into env)."
  s.author              = "mynyml"
  s.email               = "mynyml@gmail.com"
  s.homepage            = "http://github.com/mynyml/rack-abstract-format"
  s.rubyforge_project   = "rack-abstract-format"
  s.has_rdoc            =  false
  s.require_path        = "lib"
  s.files               =  File.read("Manifest").strip.split("\n")

  s.add_development_dependency 'rack'
  s.add_development_dependency 'nanotest'
end

