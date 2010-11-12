require 'tempfile'

module CoffeeScript
  module Source
    def self.read
      File.read(path)
    end

    def self.version
      '0.9.4'
    end

    def self.bare_option
      @bare_option ||= read.match(/noWrap/) ? 'noWrap' : 'bare'
    end
  end

  module JavaScriptCore
    BIN = "/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"

    class << self
      def supported?
        File.exist?(BIN)
      end

      def compile(script, options = {})
        options = options[:bare] ? "{#{Source.bare_option} : true}" : "{}"

        f = Tempfile.open("coffee.js")
        f.puts "load(#{Source.path.inspect});"
        f.puts "print(CoffeeScript.compile(#{script.inspect}, #{options}));"
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
        f.puts Source.read
        f.puts "console.log(this.CoffeeScript.compile(#{script.inspect}, #{options}));"
        f.close

        out = `node #{f.path}`
        $?.success? ? out.chomp : nil
      ensure
        f.close! if f
      end
    end
  end

  class << self
    def engines
      [Node, JavaScriptCore]
    end

    def engine
      @@engine ||= detect_engine
    end

    def engine=(engine)
      @@engine = engine
    end

    def version
      Source.version
    end

    # Compile a script (String or IO) to JavaScript.
    def compile(script, options = {})
      script = script.read if script.respond_to?(:read)

      if options.key?(:bare)
      elsif options.key?(:wrap)
        options[:bare] = !options[:wrap]
      elsif options.key?(:no_wrap)
        options[:bare] = options[:no_wrap]
      else
        options[:bare] = false
      end

      engine.compile(script, options)
    end

    private
      def detect_engine
        engines.detect { |engine| engine.supported? }
      end
  end
end
