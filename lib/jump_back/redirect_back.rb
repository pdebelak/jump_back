module JumpBack
  
  module Redirection
    
    def redirect_back(path=root_path, options={})
      options = OptionsParser.new(path: path, options: options, default: root_path)
      redirect_to PathFinder.new(request, options.path, options.jump_back_options).path, options.redirect_options
    end
  end
end