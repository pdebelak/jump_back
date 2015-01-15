require 'jump_back/referer_interpreter'
require 'jump_back/redirection_determiner'
require 'jump_back/options_parser'

module JumpBack
  
  module Redirection
    
    def redirect_back(path=root_path, options={})
      parsed_args = OptionsParser.parse(path, options, root_path)
      redirect_to RedirectionDeterminer.new(request, parsed_args[:path], parsed_args[:jump_back_options]).path, parsed_args[:redirect_options]
    end
  end
end