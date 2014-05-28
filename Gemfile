source 'https://rubygems.org'

# Specify your gem's dependencies in zonebie.gemspec
gemspec

if RUBY_VERSION <= '1.9.2'
  gem 'activesupport', '>=2.3', '<4.1'
end

platforms :rbx do
  gem 'rubysl', '~> 2.0'
  gem 'rubinius-developer_tools'
end
