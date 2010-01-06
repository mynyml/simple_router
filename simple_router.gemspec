Gem::Specification.new do |s|
  s.name                = 'simple_router'
  s.version             = "0.9.8.1"
  s.summary             = "Simple, minimalistic, standalone router meant to be used with pure rack applications"
  s.description         = "Simple, minimalistic, standalone router meant to be used with pure rack applications."
  s.author              = "mynyml"
  s.email               = "mynyml@gmail.com"
  s.homepage            = "http://github.com/mynyml/simple_router"
  s.rubyforge_project   = "simple_router"
  s.has_rdoc            =  true
  s.require_path        = "lib"
  s.files               =  File.read("Manifest").strip.split("\n")

  s.add_development_dependency 'rack'
  s.add_development_dependency 'nanotest'
  s.add_development_dependency 'nanotest_extensions'
end
