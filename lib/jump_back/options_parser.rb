module JumpBack
  
  class OptionsParser
    
    def self.parse(path, options, default)
      if path.is_a? Hash
        options = path
        path = default
      end
      
      jump_back_options = { offsite: options.delete(:offsite) }
      {
        redirect_options: options,
        jump_back_options: jump_back_options,
        path: path
      }
    end
  end
end