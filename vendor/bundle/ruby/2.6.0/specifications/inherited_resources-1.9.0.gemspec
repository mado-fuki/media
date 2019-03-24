# -*- encoding: utf-8 -*-
# stub: inherited_resources 1.9.0 ruby lib

Gem::Specification.new do |s|
  s.name = "inherited_resources".freeze
  s.version = "1.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jos\u00E9 Valim".freeze, "Rafael Mendon\u00E7a Fran\u00E7a".freeze]
  s.date = "2018-08-10"
  s.description = "Inherited Resources speeds up development by making your controllers inherit all restful actions so you just have to focus on what is important.".freeze
  s.homepage = "http://github.com/activeadmin/inherited_resources".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.0.1".freeze
  s.summary = "Inherited Resources speeds up development by making your controllers inherit all restful actions so you just have to focus on what is important.".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<responders>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 4.2", "< 5.3"])
      s.add_runtime_dependency(%q<railties>.freeze, [">= 4.2", "< 5.3"])
      s.add_runtime_dependency(%q<has_scope>.freeze, ["~> 0.6"])
    else
      s.add_dependency(%q<responders>.freeze, [">= 0"])
      s.add_dependency(%q<actionpack>.freeze, [">= 4.2", "< 5.3"])
      s.add_dependency(%q<railties>.freeze, [">= 4.2", "< 5.3"])
      s.add_dependency(%q<has_scope>.freeze, ["~> 0.6"])
    end
  else
    s.add_dependency(%q<responders>.freeze, [">= 0"])
    s.add_dependency(%q<actionpack>.freeze, [">= 4.2", "< 5.3"])
    s.add_dependency(%q<railties>.freeze, [">= 4.2", "< 5.3"])
    s.add_dependency(%q<has_scope>.freeze, ["~> 0.6"])
  end
end
