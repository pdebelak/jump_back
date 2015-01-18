module JumpBack
  
  module Helpers
    
    def link_back(name='back', path=root_path, options={})
      args = HelpersArguments.parse(name, path, options, root_path)
      link_to args[:name], PathFinder.new(request, args[:path], args[:jump_back_options]).path, args[:redirect_options]
    end
  end
  
  module HelpersArguments
    
    def self.parse(name, path, options, root_path)
      if first_arg_is_path?(name, path, root_path)
        options = path if path.is_a? Hash
        path = name
        name = 'back'
      end
      if name.is_a? Hash
        options = name
        name = 'back'
      end
      options = OptionsParser.new(default: root_path, path: path, options: options)
      { name: name, path: options.path, jump_back_options: options.jump_back_options, redirect_options: options.redirect_options }
    end
    
    def self.first_arg_is_path?(name, path, root_path)
      Urls.is_url?(name) && (path == root_path || path.is_a?(Hash))
    end
  end
end