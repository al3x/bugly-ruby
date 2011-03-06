# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bugly/version"

Gem::Specification.new do |s|
  s.name        = "sifter"
  s.version     = Bugly::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Payne"]
  s.email       = ["al3x@al3x.net"]
  s.homepage    = "http://github.com/al3x/bugly-ruby"
  s.summary     = %q{Wrapper for the Bugly API}
  s.description = %q{Query, fetch, create and modify issues stored in Bugly.}

  s.rubyforge_project = "bugly"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'httparty', '~> 0.6.1'
  s.add_dependency 'hashie', '~> 0.4.0'
end
