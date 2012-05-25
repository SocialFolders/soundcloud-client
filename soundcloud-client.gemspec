# -*- encoding: utf-8 -*-
$:.unshift File.expand_path("../lib", __FILE__)
require "soundcloud-client"

Gem::Specification.new do |s|
  s.name        = "soundcloud-client"
  s.version     = Soundcloud::VERSION
  s.authors     = ["rewritten"]
  s.email       = ["saverio@socialfolders.me", "fabien@socialfolders.me"]
  s.homepage    = "https://github.com/SocialFolders/soundcloud-client"
  s.summary     = "Soundcloud API client"
  s.description = %q{Soundcloud API client, with configurable HTTP backend}

  # s.rubyforge_project = "soundcloud-client"

  s.add_dependency("faraday", "~> 0.8.0")
  s.add_dependency("faraday_middleware")

  s.add_development_dependency("rspec")
  s.add_development_dependency("rake")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.executables   = []
  s.require_paths = ["lib"]
end
