require 'json'
require 'tempfile'

require 'coffee_script/source'

module CoffeeScript
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

  module Engines
    module JavaScriptCore
      BIN = "/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"

      class << self
        def supported?
          File.exist?(BIN)
        end

        def compile(script, options = {})
          options = options[:bare] ? "{#{Source.bare_option} : true}" : "{}"

          f = Tempfile.open("coffee.js")
          f.puts "load(#{Source.path.to_json});"
          f.puts "print(CoffeeScript.compile(#{script.to_json}, #{options}));"
          f.close

          out = `#{BIN} #{f.path}`
          $?.success? ? out.chomp : nil
        ensure
          f.close! if f
        end
      end
    end

    module Node
      class << self
        def supported?
          `which node`
          $?.success?
        end

        def compile(script, options = {})
          options = options[:bare] ? "{#{Source.bare_option} : true}" : "{}"

          f = Tempfile.open("coffee.js")
          f.puts Source.contents
          f.puts "console.log(this.CoffeeScript.compile(#{script.to_json}, #{options}));"
          f.close

          out = `node #{f.path}`
          $?.success? ? out.chomp : nil
        ensure
          f.close! if f
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
        end

        private
          def coffee_module
            @coffee_module ||= build_coffee_module
          end

          def build_coffee_module
            context = ::V8::Context.new
            context.eval(Source.contents)
            context['CoffeeScript']
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
