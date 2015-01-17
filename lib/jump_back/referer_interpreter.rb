module JumpBack
  
  module RefererInterpreter
    
    def self.back?(request, options)
      has_referer?(request) ? is_local?(request, options) ? true : false : false
    end
    
    def self.has_referer?(request)
      !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
    end
    
    def self.is_local?(request, options)
      return true if options[:offsite]
      host = host(request.env["HTTP_REFERER"])
      !(host && host != request.host)
    end
    
    def self.host(string)
      return URI.parse(string).host if uri? string
    end
    
    def self.uri?(string)
      uri = URI.parse(string)
      %w( http https ).include?(uri.scheme)
      rescue URI::BadURIError
      false
      rescue URI::InvalidURIError
      false
    end
  end
end