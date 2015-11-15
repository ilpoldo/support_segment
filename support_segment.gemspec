$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "support_segment/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "support_segment"
  s.version     = SupportSegment::VERSION
  s.authors     = ["Leandro Pedroni"]
  s.email       = ["ilpoldo@gmail.com"]
  s.homepage    = "https://github.com/ilpoldo/support_segment"
  s.summary     = "Support modules for rails applications."
  s.description = "Support modules for rails applications."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.1.8"
  
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec-collection_matchers'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'

  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'guard-rspec'

  s.add_development_dependency 'pry'
end
