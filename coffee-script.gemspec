Gem::Specification.new do |s|
  s.name      = 'coffee-script'
  s.version   = '2.2.0'
  s.date      = '2010-03-11'

  s.homepage    = "http://github.com/josh/ruby-coffee-script"
  s.summary     = "Ruby CoffeeScript Compiler"
  s.description = <<-EOS
    Ruby CoffeeScript is a bridge to the JS CoffeeScript compiler.
  EOS

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

  s.authors = ['Jeremy Ashkenas', 'Joshua Peek', 'Sam Stephenson']
  s.email   = 'josh@joshpeek.com'
end
