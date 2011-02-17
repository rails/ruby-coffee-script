Gem::Specification.new do |s|
  s.name      = 'coffee-script'
  s.version   = '2.1.3'
  s.date      = '2010-02-06'

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
  s.add_development_dependency 'therubyracer'

  s.authors           = ['Jeremy Ashkenas', 'Joshua Peek', 'Sam Stephenson']
  s.email             = 'josh@joshpeek.com'
  s.rubyforge_project = 'coffee-script'
end
