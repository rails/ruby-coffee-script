require 'coffee_script'
require 'test/unit'
require 'stringio'

class TestCoffeeScript < Test::Unit::TestCase
  def test_compile
    assert_equal "(function() {\n  puts('Hello, World!');\n}).call(this);\n",
      CoffeeScript.compile("puts 'Hello, World!'\n")
  end

  def test_compile_with_io
    io = StringIO.new("puts 'Hello, World!'\n")
    assert_equal "(function() {\n  puts('Hello, World!');\n}).call(this);\n",
      CoffeeScript.compile(io)
  end

  def test_compile_with_wrap_true
    assert_equal "(function() {\n  puts('Hello, World!');\n}).call(this);\n",
      CoffeeScript.compile("puts 'Hello, World!'\n", :wrap => true)
  end

  def test_compile_with_wrap_false
    assert_equal "puts('Hello, World!');",
      CoffeeScript.compile("puts 'Hello, World!'\n", :wrap => false)
  end

  def test_compile_with_bare
    assert_equal "puts('Hello, World!');",
      CoffeeScript.compile("puts 'Hello, World!'\n", :bare => true)
  end

  def test_compile_with_no_wrap
    assert_equal "puts('Hello, World!');",
      CoffeeScript.compile("puts 'Hello, World!'\n", :no_wrap => true)
  end

  def test_evaluate
    assert_equal "howdy\n",
    CoffeeScript.evaluate("require('sys').puts('howdy')")
  end

  def test_evaluate_with_io
    io = StringIO.new("puts 'howdy'\n")
    assert_equal "howdy\n", CoffeeScript.evaluate(io)
  end

  def test_evaluate_with_args
    script = <<-EOS
      require("sys").puts(process.argv[3] + " and " + process.argv[4])
    EOS

    assert_equal "first and second\n",
    CoffeeScript.evaluate(script, 'first', 'second')
  end
end
