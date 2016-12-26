Gem::Specification.new do |s|
  s.name        = "themizer"
  s.version     = "0.9"
  s.date        = "2016-12-26"
  s.summary     = "Gem for producing themed css from scss.erb"
  s.description = "Provides methods which expands you regular SASS in rails into themed one using & operator and other cool SASS features."
  s.authors     = ["Alexander Morozov"]
  s.email       = "ntcomp12@gmail.com"
  s.files       = ["lib/themizer.rb"]
  s.homepage    = "https://github.com/kengho/themizer"
  s.license     = "MIT"

  s.add_runtime_dependency "ruby_expect", "~> 1"
end
