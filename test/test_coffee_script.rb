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

  def test_compilation_error
    assert_raise CoffeeScript::CompilationError do
      CoffeeScript.compile("unless")
    end
  end

  def test_error_messages_omit_leading_error_string
    assert_exception_does_not_match(/^Error: /) { CoffeeScript.compile("unless") }   # parse error
    assert_exception_does_not_match(/^Error: /) { CoffeeScript.compile("function") } # syntax error
  end

  def assert_exception_does_not_match(pattern)
    yield
    flunk "no exception raised"
  rescue Exception => e
    assert_no_match pattern, e.message
  end
end

CoffeeScript::Engines.constants.each do |const|
  engine = CoffeeScript::Engines.const_get(const)
  unless engine.supported?
    warn "*** skipping #{const} tests"
    next
  end

  instance_eval <<-RUBY, __FILE__, __LINE__ + 1
    class Test#{const} < Test::Unit::TestCase
      include CoffeeScriptTests

      def setup
        CoffeeScript.engine = CoffeeScript::Engines::#{const}
      end
    end
  RUBY
end
