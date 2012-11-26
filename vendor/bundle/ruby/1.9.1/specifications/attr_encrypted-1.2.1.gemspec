# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "attr_encrypted"
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sean Huber"]
  s.date = "2012-09-11"
  s.description = "Generates attr_accessors that encrypt and decrypt attributes transparently"
  s.email = "shuber@huberry.com"
  s.homepage = "http://github.com/shuber/attr_encrypted"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.21"
  s.summary = "Encrypt and decrypt attributes"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<encryptor>, [">= 1.1.1"])
      s.add_development_dependency(%q<activerecord>, [">= 2.0.0"])
      s.add_development_dependency(%q<datamapper>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<sequel>, [">= 0"])
    else
      s.add_dependency(%q<encryptor>, [">= 1.1.1"])
      s.add_dependency(%q<activerecord>, [">= 2.0.0"])
      s.add_dependency(%q<datamapper>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<sequel>, [">= 0"])
    end
  else
    s.add_dependency(%q<encryptor>, [">= 1.1.1"])
    s.add_dependency(%q<activerecord>, [">= 2.0.0"])
    s.add_dependency(%q<datamapper>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<sequel>, [">= 0"])
  end
end
