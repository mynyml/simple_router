require 'pathname'
require 'nanotest'
require 'nanotest/spec'
require 'nanotest/contexts'
begin
  require 'ruby-debug'
  require 'redgreen'        # gem install mynyml-redgreen
  require 'nanotest/stats'
  require 'nanotest/focus'
rescue LoadError, RuntimeError
end

$:.unshift Pathname(__FILE__).dirname.parent + 'lib' 
require 'simple_router'

include Nanotest
include Nanotest::Contexts
