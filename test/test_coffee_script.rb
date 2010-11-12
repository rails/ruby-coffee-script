require 'coffee_script'
require 'test/unit'
require 'stringio'

module CoffeeScriptTests
  def test_compile
    assert_equal "(function() {\n  puts('Hello, World!');\n}).call(this);\n",
      CoffeeScript.compile("puts 'Hello, World!'\n")
  end

  def test_compile_with_io
    io = StringIO.new("puts 'Hello, World!'\n")
    assert_equal "(function() {\n  puts('Hello, World!');\n}).call(this);\n",
      CoffeeScript.compile(io)
  end

  def test_compile_with_bare_true
    assert_equal "puts('Hello, World!');",
      CoffeeScript.compile("puts 'Hello, World!'\n", :bare => true)
  end

  def test_compile_with_bare_false
    assert_equal "(function() {\n  puts('Hello, World!');\n}).call(this);\n",
      CoffeeScript.compile("puts 'Hello, World!'\n", :bare => false)
  end

  def test_compile_with_no_wrap_true
    assert_equal "puts('Hello, World!');",
      CoffeeScript.compile("puts 'Hello, World!'\n", :no_wrap => true)
  end

  def test_compile_with_no_wrap
    assert_equal "(function() {\n  puts('Hello, World!');\n}).call(this);\n",
      CoffeeScript.compile("puts 'Hello, World!'\n", :no_wrap => false)
  end
end

CoffeeScript::Engines.constants.each do |const|
  engine = CoffeeScript::Engines.const_get(const)
  warn "*** skipping #{const} tests" and next unless engine.supported?

  instance_eval <<-RUBY, __FILE__, __LINE__ + 1
    class Test#{const} < Test::Unit::TestCase
      include CoffeeScriptTests

      def setup
        CoffeeScript.engine = CoffeeScript::Engines::#{const}
      end
    end
  RUBY
end
