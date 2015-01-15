require 'jump_back/options_parser'

module JumpBack
  
  module Redirection
    
    def save_referer
      session[:jump_back_stored_referer] ||= request.referer
    end
  
    def return_to_referer(path=root_path, options={})
      parsed_args = OptionsParser.parse(path, options, root_path)
      session[:jump_back_stored_referer] ? redirect_to(clear_referer, parsed_args[:redirect_options]) : redirect_to(parsed_args[:path], parsed_args[:redirect_options])
    end
  
    def clear_referer
      session.delete(:jump_back_stored_referer)
    end
  end
end