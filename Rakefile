def gem_opt
  defined?(Gem) ? "-rubygems" : ""
end

def ruby(path)
  path = "-e'%w( #{path.join(' ')} ).each {|p| require p }'" if path.is_a?(Array)
  system "ruby #{gem_opt} -I.:lib:test #{path}"
end

# --------------------------------------------------
# Tests
# --------------------------------------------------
task(:default => :test)

desc "Run tests"
task(:test) do
  exit ruby( Dir['test/**/test_*.rb'] - ['test/test_helper.rb'] )
end

# --------------------------------------------------
# Docs
# --------------------------------------------------
desc "Generate YARD Documentation"
task(:yardoc) do
  require 'yard'
  files   = %w( lib/**/*.rb )
  options = %w( -o doc/yard --readme README --files LICENSE )
  YARD::CLI::Yardoc.run *(options + files)
end

