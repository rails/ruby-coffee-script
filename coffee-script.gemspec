Gem::Specification.new do |s|
  s.name      = 'coffee-script'
  s.version   = '0.9.0'
  s.date      = '2010-9-10'

  s.homepage    = "http://github.com/josh/ruby-coffee-script"
  s.summary     = "The CoffeeScript Compiler"
  s.description = <<-EOS
    CoffeeScript is a little language that compiles into JavaScript. Think
    of it as JavaScript's less ostentatious kid brother -- the same genes,
    roughly the same height, but a different sense of style. Apart from a
    handful of bonus goodies, statements in CoffeeScript correspond
    one-to-one with their equivalent in JavaScript, it's just another
    way of saying it.
  EOS

  s.files = [
    'lib/coffee-script.rb',
    'lib/coffee_script.rb',
    'LICENSE',
    'README.md'
  ]

  s.requirements << 'node'
  s.requirements << 'coffee-script'

  s.authors           = ['Jeremy Ashkenas', 'Joshua Peek']
  s.email             = 'josh@joshpeek.com'
  s.rubyforge_project = 'coffee-script'
end
