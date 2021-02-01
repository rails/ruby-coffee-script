Gem::Specification.new do |s|
  s.name    = 'coffee-script'
  s.version = '2.5.1'

  s.homepage    = "http://github.com/rails/ruby-coffee-script"
  s.summary     = "Ruby CoffeeScript Compiler"
  s.description = <<-EOS
    Ruby CoffeeScript is a bridge to the JS CoffeeScript compiler.
  EOS
  s.license = "MIT"

  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/rails/ruby-coffee-script/issues",
    "documentation_uri" => "https://www.rubydoc.info/gems/coffee-script/#{s.version}",
    "source_code_uri"   => "https://github.com/rails/ruby-coffee-script/tree/v#{s.version}",
  }

  s.files = [
    'lib/coffee-script.rb',
    'lib/coffee_script.rb',
    'LICENSE',
    'README.md'
  ]

  s.add_dependency 'coffee-script-source'
  s.add_dependency 'execjs'
  s.add_development_dependency 'json'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'

  s.authors = ['Jeremy Ashkenas', 'Joshua Peek', 'Sam Stephenson']
  s.email   = 'josh@joshpeek.com'
end
