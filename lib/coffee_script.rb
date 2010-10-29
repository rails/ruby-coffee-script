module CoffeeScript
  class << self
    def locate_coffee_bin
      out = `which coffee`
      if $?.success?
        out.chomp
      else
        raise LoadError, "could not find `coffee` in PATH"
      end
    end

    def coffee_bin
      @@coffee_bin ||= locate_coffee_bin
    end

    def coffee_bin=(path)
      @@coffee_bin = path
    end

    def version
      `#{coffee_bin} --version`[/(\d|\.)+/]
    end

    # Compile a script (String or IO) to JavaScript.
    def compile(script, options = {})
      script = script.read if script.respond_to?(:read)
      command = "#{coffee_bin} -sp"

      if options[:wrap] == false ||
          options.key?(:bare) ||
          options.key?(:no_wrap)
        command += " --#{no_wrap_flag}"
      end

      IO.popen(command, "w+") do |f|
        f << script
        f.close_write
        f.read
      end
    end

    private
      def no_wrap_flag
        `#{coffee_bin} --help`.lines.grep(/--no-wrap/).any? ? 'no-wrap' : 'bare'
      end
  end
end
