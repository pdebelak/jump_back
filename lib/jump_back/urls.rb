module JumpBack
  
  module Urls
    
    def self.is_url?(string)
      is_uri?(string) || is_path?(string)
    end
    
    def self.uri(string)
      URI.parse string if is_uri? string
    end
    
    def self.is_uri?(string)
      uri = URI.parse string
      %w( http https ).include? uri.scheme
      rescue URI::BadURIError
      false
      rescue URI::InvalidURIError
      false
    end
    
    def self.is_path?(string)
      !!(Rails.application.routes.recognize_path string)
      rescue ActionController::RoutingError
      false
    end
  end
end