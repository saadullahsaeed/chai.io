# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sequel"
  s.version = "3.41.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeremy Evans"]
  s.date = "2012-11-01"
  s.description = "The Database Toolkit for Ruby"
  s.email = "code@jeremyevans.net"
  s.executables = ["sequel"]
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "MIT-LICENSE", "doc/active_record.rdoc", "doc/advanced_associations.rdoc", "doc/association_basics.rdoc", "doc/cheat_sheet.rdoc", "doc/dataset_basics.rdoc", "doc/dataset_filtering.rdoc", "doc/migration.rdoc", "doc/model_hooks.rdoc", "doc/opening_databases.rdoc", "doc/prepared_statements.rdoc", "doc/querying.rdoc", "doc/reflection.rdoc", "doc/sharding.rdoc", "doc/sql.rdoc", "doc/validations.rdoc", "doc/virtual_rows.rdoc", "doc/mass_assignment.rdoc", "doc/testing.rdoc", "doc/schema_modification.rdoc", "doc/transactions.rdoc", "doc/thread_safety.rdoc", "doc/object_model.rdoc", "doc/core_extensions.rdoc", "doc/bin_sequel.rdoc", "doc/release_notes/1.0.txt", "doc/release_notes/1.1.txt", "doc/release_notes/1.3.txt", "doc/release_notes/1.4.0.txt", "doc/release_notes/1.5.0.txt", "doc/release_notes/2.0.0.txt", "doc/release_notes/2.1.0.txt", "doc/release_notes/2.10.0.txt", "doc/release_notes/2.11.0.txt", "doc/release_notes/2.12.0.txt", "doc/release_notes/2.2.0.txt", "doc/release_notes/2.3.0.txt", "doc/release_notes/2.4.0.txt", "doc/release_notes/2.5.0.txt", "doc/release_notes/2.6.0.txt", "doc/release_notes/2.7.0.txt", "doc/release_notes/2.8.0.txt", "doc/release_notes/2.9.0.txt", "doc/release_notes/3.0.0.txt", "doc/release_notes/3.1.0.txt", "doc/release_notes/3.10.0.txt", "doc/release_notes/3.11.0.txt", "doc/release_notes/3.12.0.txt", "doc/release_notes/3.13.0.txt", "doc/release_notes/3.14.0.txt", "doc/release_notes/3.15.0.txt", "doc/release_notes/3.16.0.txt", "doc/release_notes/3.17.0.txt", "doc/release_notes/3.18.0.txt", "doc/release_notes/3.19.0.txt", "doc/release_notes/3.2.0.txt", "doc/release_notes/3.20.0.txt", "doc/release_notes/3.21.0.txt", "doc/release_notes/3.22.0.txt", "doc/release_notes/3.23.0.txt", "doc/release_notes/3.24.0.txt", "doc/release_notes/3.25.0.txt", "doc/release_notes/3.3.0.txt", "doc/release_notes/3.4.0.txt", "doc/release_notes/3.5.0.txt", "doc/release_notes/3.6.0.txt", "doc/release_notes/3.7.0.txt", "doc/release_notes/3.8.0.txt", "doc/release_notes/3.9.0.txt", "doc/release_notes/3.26.0.txt", "doc/release_notes/3.27.0.txt", "doc/release_notes/3.28.0.txt", "doc/release_notes/3.29.0.txt", "doc/release_notes/3.30.0.txt", "doc/release_notes/3.31.0.txt", "doc/release_notes/3.32.0.txt", "doc/release_notes/3.33.0.txt", "doc/release_notes/3.34.0.txt", "doc/release_notes/3.35.0.txt", "doc/release_notes/3.36.0.txt", "doc/release_notes/3.37.0.txt", "doc/release_notes/3.38.0.txt", "doc/release_notes/3.39.0.txt", "doc/release_notes/3.40.0.txt", "doc/release_notes/3.41.0.txt"]
  s.files = ["bin/sequel", "README.rdoc", "CHANGELOG", "MIT-LICENSE", "doc/active_record.rdoc", "doc/advanced_associations.rdoc", "doc/association_basics.rdoc", "doc/cheat_sheet.rdoc", "doc/dataset_basics.rdoc", "doc/dataset_filtering.rdoc", "doc/migration.rdoc", "doc/model_hooks.rdoc", "doc/opening_databases.rdoc", "doc/prepared_statements.rdoc", "doc/querying.rdoc", "doc/reflection.rdoc", "doc/sharding.rdoc", "doc/sql.rdoc", "doc/validations.rdoc", "doc/virtual_rows.rdoc", "doc/mass_assignment.rdoc", "doc/testing.rdoc", "doc/schema_modification.rdoc", "doc/transactions.rdoc", "doc/thread_safety.rdoc", "doc/object_model.rdoc", "doc/core_extensions.rdoc", "doc/bin_sequel.rdoc", "doc/release_notes/1.0.txt", "doc/release_notes/1.1.txt", "doc/release_notes/1.3.txt", "doc/release_notes/1.4.0.txt", "doc/release_notes/1.5.0.txt", "doc/release_notes/2.0.0.txt", "doc/release_notes/2.1.0.txt", "doc/release_notes/2.10.0.txt", "doc/release_notes/2.11.0.txt", "doc/release_notes/2.12.0.txt", "doc/release_notes/2.2.0.txt", "doc/release_notes/2.3.0.txt", "doc/release_notes/2.4.0.txt", "doc/release_notes/2.5.0.txt", "doc/release_notes/2.6.0.txt", "doc/release_notes/2.7.0.txt", "doc/release_notes/2.8.0.txt", "doc/release_notes/2.9.0.txt", "doc/release_notes/3.0.0.txt", "doc/release_notes/3.1.0.txt", "doc/release_notes/3.10.0.txt", "doc/release_notes/3.11.0.txt", "doc/release_notes/3.12.0.txt", "doc/release_notes/3.13.0.txt", "doc/release_notes/3.14.0.txt", "doc/release_notes/3.15.0.txt", "doc/release_notes/3.16.0.txt", "doc/release_notes/3.17.0.txt", "doc/release_notes/3.18.0.txt", "doc/release_notes/3.19.0.txt", "doc/release_notes/3.2.0.txt", "doc/release_notes/3.20.0.txt", "doc/release_notes/3.21.0.txt", "doc/release_notes/3.22.0.txt", "doc/release_notes/3.23.0.txt", "doc/release_notes/3.24.0.txt", "doc/release_notes/3.25.0.txt", "doc/release_notes/3.3.0.txt", "doc/release_notes/3.4.0.txt", "doc/release_notes/3.5.0.txt", "doc/release_notes/3.6.0.txt", "doc/release_notes/3.7.0.txt", "doc/release_notes/3.8.0.txt", "doc/release_notes/3.9.0.txt", "doc/release_notes/3.26.0.txt", "doc/release_notes/3.27.0.txt", "doc/release_notes/3.28.0.txt", "doc/release_notes/3.29.0.txt", "doc/release_notes/3.30.0.txt", "doc/release_notes/3.31.0.txt", "doc/release_notes/3.32.0.txt", "doc/release_notes/3.33.0.txt", "doc/release_notes/3.34.0.txt", "doc/release_notes/3.35.0.txt", "doc/release_notes/3.36.0.txt", "doc/release_notes/3.37.0.txt", "doc/release_notes/3.38.0.txt", "doc/release_notes/3.39.0.txt", "doc/release_notes/3.40.0.txt", "doc/release_notes/3.41.0.txt"]
  s.homepage = "http://sequel.rubyforge.org"
  s.rdoc_options = ["--quiet", "--line-numbers", "--inline-source", "--title", "Sequel: The Database Toolkit for Ruby", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = "sequel"
  s.rubygems_version = "1.8.21"
  s.summary = "The Database Toolkit for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
