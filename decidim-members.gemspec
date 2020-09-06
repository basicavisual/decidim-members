# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "decidim/members/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "decidim-members"
  s.version     = Decidim::Members::VERSION
  s.authors     = ["Jens Kraemer"]
  s.email       = ["jk@jkraemer.net"]
  #s.homepage    = "TODO"
  s.summary = "Member list and search plugin for decidim"
  s.description = s.summary
  s.license     = "AGPL 3.0"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", ">= 0.13.0"
  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "sanitize"

  s.add_development_dependency "decidim-dev", '>= 0.9.0'
  s.add_development_dependency "decidim-admin", '>= 0.9.0'
  s.add_development_dependency 'sqlite3'
end
