module JumpBack
  
  class RedirectionDeterminer
    attr_reader :path
    
    def initialize(request, path, options)
      @path = path_determiner(request, path, options)
    end
    
    def path_determiner(request, path, options)
      RefererInterpreter.back?(request, options) ? :back : path
    end
  end
end