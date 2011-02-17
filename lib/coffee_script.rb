require 'json'
require 'tempfile'

require 'coffee_script/source'

module CoffeeScript
  class Error  < ::StandardError; end
  class EngineError      < Error; end
  class CompilationError < Error; end

  module Source
    def self.path
      @path ||= ENV['COFFEESCRIPT_SOURCE_PATH'] || bundled_path
    end

    def self.path=(path)
      @contents = @version = @bare_option = nil
      @path = path
    end

    def self.contents
      @contents ||= File.read(path)
    end

    def self.version
      @version ||= contents[/CoffeeScript Compiler v([\d.]+)/, 1]
    end

    def self.bare_option
      @bare_option ||= contents.match(/noWrap/) ? 'noWrap' : 'bare'
    end
  end

  module ExternalEngine
    class << self
      def compile(command, script, options)
        yield f = Tempfile.open("coffee.js")
        f.puts compile_js(script, options)
        f.close

        execute("#{command} #{f.path}")
      ensure
        f.close! if f
      end

      def execute(command)
        out = `#{command}`.chomp
        if $?.success?
          status, result = out[0, 1], out[1..-1]
          if status == "+"
            result
          else
            raise CompilationError, result[/^(?:Error: )?(.*)/, 1]
          end
        else
          raise EngineError, out
        end
      end

      def compile_js(script, options)
        options = options[:bare] ? "{#{Source.bare_option} : true}" : "{}"
        <<-JS
          try {
            print('+' + CoffeeScript.compile(#{script.to_json}, #{options}));
          } catch (e) {
            print('-' + e);
          }
        JS
      end
    end
  end

  module Engines
    module JavaScriptCore
      BIN = "/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"

      class << self
        def supported?
          File.exist?(BIN)
        end

        def compile(script, options = {})
          ExternalEngine.compile(BIN, script, options) do |f|
            f.puts "load(#{Source.path.to_json});"
          end
        end
      end
    end

    module Node
      class << self

        def binary
          @binary ||= `sh -c "which nodejs node"`.split("\n").first
        end

        def binary=(value)
          @binary = value.nil? ? nil : value.to_s
        end

        def supported?
          binary
        end

        def compile(script, options = {})
          ExternalEngine.compile(binary, script, options) do |f|
            f.puts Source.contents
            f.puts "var CoffeeScript = this.CoffeeScript, print = console.log;"
          end
        end
      end
    end

    module V8
      class << self
        def supported?
          require 'v8'
          true
        rescue LoadError
          false
        end

        def compile(script, options = {})
          coffee_module['compile'].call(script, Source.bare_option => options[:bare])
        rescue ::V8::JSError => e
          raise CompilationError, e.message
        end

        private
          def coffee_module
            @coffee_module ||= build_coffee_module
          end

          def build_coffee_module
            context = ::V8::Context.new
            context.eval(Source.contents)
            context['CoffeeScript']
          rescue ::V8::JSError => e
            raise EngineError, e.message
          end
      end
    end
  end

  class << self
    def engine
      @engine ||= nil
    end

    def engine=(engine)
      @engine = engine
    end

    def version
      Source.version
    end

    # Compile a script (String or IO) to JavaScript.
    def compile(script, options = {})
      script = script.read if script.respond_to?(:read)

      if options.key?(:bare)
      elsif options.key?(:no_wrap)
        options[:bare] = options[:no_wrap]
      else
        options[:bare] = false
      end

      engine.compile(script, options)
    end
  end

  self.engine ||= [
    Engines::V8,
    Engines::Node,
    Engines::JavaScriptCore
  ].detect(&:supported?)
end
