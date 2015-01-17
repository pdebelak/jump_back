module JumpBack
  
  class OptionsParser
    
    attr_reader :path, :redirect_options, :jump_back_options
    
    def initialize(options)
      @path = parse(options)[:path]
      @redirect_options = parse(options)[:redirect_options]
      @jump_back_options = parse(options)[:jump_back_options]
    end
    
    def parse(options)
      return @options if @options
      
      if options[:path].is_a? Hash
        options[:options] = options[:path]
        options[:path] = options[:default]
      end
      
      options[:jump_back_options] = { offsite: options[:options].delete(:offsite) }
      options[:redirect_options] = options.delete(:options)
      @options = options
    end
  end
end