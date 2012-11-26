# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "eco-source"
  s.version = "1.1.0.rc.1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sam Stephenson"]
  s.date = "2011-06-03"
  s.description = "JavaScript source code for the Eco (Embedded CoffeeScript template language) compiler"
  s.email = "sstephenson@gmail.com"
  s.homepage = "https://github.com/sstephenson/eco/"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.21"
  s.summary = "Eco compiler source"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
