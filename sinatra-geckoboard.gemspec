# encoding: utf-8
Gem::Specification.new do |s|
  s.name                         = 'sinatra-geckoboard'
  s.version                      = '0.1.2'
  s.date                         = Time.now.utc.strftime("%Y-%m-%d")
  s.homepage                     = "https://github.com/AF83/sinatra-geckoboard"
  s.authors                      = "François de Metz"
  s.email                        = "francois.de.metz@af83.com"
  s.description                  = "A little Sinatra extension to expose data nicely to Geckoboard."
  s.summary                      = "A little Sinatra extension to expose data nicely to Geckoboard."
  s.extra_rdoc_files             = %w(README.md)
  s.files                        = Dir["README.md", "Gemfile", "lib/**/*.rb"]
  s.require_paths                = ["lib"]
  s.rubygems_version             = %q{1.3.7}
  s.add_dependency "sinatra", ">= 1.0"
  s.add_dependency "json", "~> 1.0"
  s.add_development_dependency "bundler"
  s.add_development_dependency "minitest", "~> 2.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "rack-test"
end
