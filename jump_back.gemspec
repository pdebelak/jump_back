$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "jump_back/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jump_back"
  s.version     = JumpBack::VERSION
  s.authors     = ["Peter Debelak"]
  s.email       = ["pdebelak@gmail.com"]
  s.summary     = "jump_back simplifies redirecting back in rails"
  s.description = "jump_back helps you redirect to back with a default and simplifies saving a referring page for future redirects. See website https://github.com/pdebelak/jump_back for details."
  s.homepage    = "https://github.com/pdebelak/jump_back"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4.0.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
end
