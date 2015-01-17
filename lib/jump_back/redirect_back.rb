require 'jump_back/referer_interpreter'
require 'jump_back/redirection_determiner'
require 'jump_back/options_parser'

module JumpBack
  
  module Redirection
    
    def redirect_back(path=root_path, options={})
      options = OptionsParser.new(path: path, options: options, default: root_path)
      redirect_to RedirectionDeterminer.new(request, options.path, options.jump_back_options).path, options.redirect_options
    end
  end
end