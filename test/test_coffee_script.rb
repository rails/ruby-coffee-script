require 'coffee_script'
require 'test/unit'
require 'stringio'

class TestCoffeeScript < Test::Unit::TestCase
  def test_compile
    assert_equal "(function() {\n  puts('Hello, World!');\n})();\n",
      CoffeeScript.compile("puts 'Hello, World!'\n")
  end

  def test_compile_with_io
    io = StringIO.new("puts 'Hello, World!'\n")
    assert_equal "(function() {\n  puts('Hello, World!');\n})();\n",
      CoffeeScript.compile(io)
  end

  def test_compile_with_no_wrap
    assert_equal "puts('Hello, World!');",
      CoffeeScript.compile("puts 'Hello, World!'\n", :no_wrap => true)
  end
end
