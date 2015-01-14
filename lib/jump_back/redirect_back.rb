require 'jump_back/referer_interpreter'
require 'jump_back/redirection_determiner'

module JumpBack
  
  def redirect_back(path=root_path, options={})
    parsed_args = parse_jump_back_arguments(path, options)
    redirect_to RedirectionDeterminer.new(request, parsed_args[:path], parsed_args[:jump_back_options]).path, parsed_args[:redirect_options]
  end
  
  def parse_jump_back_arguments(path, options)
    if path.is_a? Hash
      options = path
      path = root_path
    end
    
    jump_back_options = { offsite: options.delete(:offsite) }
    {
      redirect_options: options,
      jump_back_options: jump_back_options,
      path: path
    }
  end
end