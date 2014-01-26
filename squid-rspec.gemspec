lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include? lib

require 'squid-rspec/version'

Gem::Specification.new do |s|
  s.name        = 'squid-rspec'
  s.version     = Squid::VERSION
  s.authors     = 'Daniel Harrington'
  s.email       = 'me@rubiii.com'
  s.homepage    = 'http://savonrb.com'
  s.summary     = 'Reports RSpec test results to Squid'
  s.description = s.summary

  s.rubyforge_project = s.name
  s.license = 'MIT'

  s.add_dependency 'httpclient'
  s.add_dependency 'rspec'

  s.add_development_dependency 'rake'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.require_paths = ['lib']
end
