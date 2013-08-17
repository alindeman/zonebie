# -*- encoding: utf-8 -*-
require File.expand_path('../lib/zonebie/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Andy Lindeman', 'Steven Harman', 'Patrick Van Stee']
  gem.email         = ['andy@andylindeman.com', 'steveharman@gmail.com', 'patrickvanstee@gmail.com']
  gem.description   = %q{Runs your tests in a random timezone}
  gem.summary       = %q{Zonebie prevents bugs in code that deals with timezones by randomly assigning a zone on every run}
  gem.homepage      = "https://github.com/alindeman/zonebie"
  gem.license       = 'MIT'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "zonebie"
  gem.require_paths = ["lib"]
  gem.version       = Zonebie::VERSION

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~>2.14"
  gem.add_development_dependency "mocha", "~>0.14.0"

  gem.add_development_dependency "activesupport", ">=2.3"
  gem.add_development_dependency "tzinfo", "~>1.0", ">= 1.0.1"
  gem.add_development_dependency "tzinfo-data", ">= 1.2013.4"
end
