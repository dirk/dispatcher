# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{stevenson}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dirk Gadsden"]
  s.date = %q{2011-06-02}
  s.description = %q{}
  s.email = %q{dirk@esherido.com}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    "README.textile",
    "Rakefile",
    "VERSION",
    "lib/stevenson.rb",
    "lib/stevenson/application.rb",
    "lib/stevenson/delegator.rb",
    "lib/stevenson/nest.rb",
    "lib/stevenson/nests/collection.rb",
    "lib/stevenson/page.rb",
    "lib/stevenson/server.rb",
    "lib/stevenson/templates.rb",
    "stevenson.gemspec",
    "test/about.rb",
    "test/app.rb",
    "test/config.ru",
    "test/index.erb",
    "test/index.rb",
    "test/layouts/default.erb",
    "test/people.erb",
    "test/people.rb",
    "test/people/jane.rb",
    "test/people/jane_smith.erb",
    "test/people/john.rb",
    "test/people/john_smith.erb",
    "test/public/images/barcamp.png",
    "test/sinatra_test_app.rb",
    "test/sinatra_test_config.ru"
  ]
  s.homepage = %q{http://github.com/dirk/stevenson}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 1.1.0"])
      s.add_runtime_dependency(%q<haml>, [">= 3.0.24"])
      s.add_runtime_dependency(%q<rack>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 1.1.0"])
      s.add_dependency(%q<haml>, [">= 3.0.24"])
      s.add_dependency(%q<rack>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 1.1.0"])
    s.add_dependency(%q<haml>, [">= 3.0.24"])
    s.add_dependency(%q<rack>, [">= 0"])
  end
end
