module JumpBack
  
  class PathFinder
    attr_reader :path
    
    def initialize(request, path, options)
      @uri = Urls.uri(request.env["HTTP_REFERER"])
      @path = determine_path(request, path, options)
    end
    
    def redirect_back?(request, options)
      has_referer?(request) ? is_local?(request, options) ? true : false : false
    end
    
    def has_referer?(request)
      !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
    end
    
    def is_local?(request, options)
      return true if options[:offsite]
      !(host && host != request.host)
    end
    
    private
    
      attr_reader :uri
    
      def determine_path(request, path, options)
        redirect_back?(request, options) ? :back : path
      end
    
      def host
        uri.host if uri
      end
  end
end