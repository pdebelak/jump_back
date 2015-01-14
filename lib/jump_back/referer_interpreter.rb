module JumpBack
  
  class RefererInterpreter
    
    def back?(request, options)
      has_referer?(request) ? is_local?(request, options) ? true : false : false
    end
    
    def has_referer?(request)
      !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
    end
    
    def is_local?(request, options)
      return true if options[:offsite]
      host = host(request.env["HTTP_REFERER"])
      !(host && host != request.host)
    end
    
    private
    
      def host(string)
        return URI.parse(string).host if uri? string
      end
    
      def uri?(string)
        uri = URI.parse(string)
        %w( http https ).include?(uri.scheme)
        rescue URI::BadURIError
        false
        rescue URI::InvalidURIError
        false
      end
  end
end