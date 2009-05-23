--- !ruby/object:Gem::Specification 
name: simple_router
version: !ruby/object:Gem::Version 
  version: "0.9"
platform: ruby
authors: 
- Martin Aumont
autorequire: 
bindir: bin
cert_chain: []

date: 2009-05-23 00:00:00 -04:00
default_executable: 
dependencies: []

description: Simple, minimalistic, standalone router meant to be used with pure rack applications.
email: mynyml@gmail.com
executables: []

extensions: []

extra_rdoc_files: []

files: 
- Rakefile
- test
- test/engines
- test/engines/test_simple_engine.rb
- test/test_simple_router.rb
- test/test_dsl.rb
- test/test_routes.rb
- test/test_helper.rb
- examples
- examples/rack_app.ru
- simple_router.gemspec
- TODO
- lib
- lib/simple_router
- lib/simple_router/routes.rb
- lib/simple_router/engines
- lib/simple_router/engines/simple_engine.rb
- lib/simple_router/dsl.rb
- lib/simple_router.rb
- doc
- LICENSE
- README
has_rdoc: true
homepage: ""
licenses: []

post_install_message: 
rdoc_options: []

require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
required_rubygems_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
requirements: []

rubyforge_project: 
rubygems_version: 1.3.3
signing_key: 
specification_version: 3
summary: Simple, minimalistic, standalone router meant to be used with pure rack applications.
test_files: []

