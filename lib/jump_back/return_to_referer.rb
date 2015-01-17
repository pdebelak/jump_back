require 'jump_back/options_parser'

module JumpBack
  
  module Redirection
    
    def save_referer
      session[:jump_back_stored_referer] ||= request.referer
    end
  
    def return_to_referer(path=root_path, options={})
      options = OptionsParser.new(path: path, options: options, default: root_path)
      session[:jump_back_stored_referer] ? redirect_to(clear_referer, options.redirect_options) : redirect_to(options.path, options.redirect_options)
    end
  
    def clear_referer
      session.delete(:jump_back_stored_referer)
    end
  end
end