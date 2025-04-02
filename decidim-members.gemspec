# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "decidim/members/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "decidim-members"
  s.version     = Decidim::Members::VERSION
  s.authors     = ["Jens Kraemer", "Ali González"]
  s.email       = ["ali@basicavisual.io"]
  s.homepage    = "https://github.com/basicavisual/decidim-members"
  s.summary = "Member list and search plugin for decidim"
  s.description = "A gem to list and search members in a Decidim installation."
  s.license     = "AGPL-3.0"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "Rakefile", "README.md"]
  s.required_ruby_version = '~> 2.7.1'
  s.add_dependency "decidim-core", "~> 0.25.2"
  s.add_dependency "rails", "~> 6.0.4"
  s.add_dependency "sanitize", "~> 6.1.3"

  s.add_development_dependency "decidim-dev", '~> 0.25.2'
  s.add_development_dependency "decidim-admin", '~> 0.25.2'
  s.add_development_dependency "sqlite3", "~> 1.4"
end
