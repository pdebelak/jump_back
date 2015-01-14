module JumpBack
  
  def save_referer
    session[:jump_back_stored_referer] ||= request.referer
  end

  def return_to_referer(path=root_path)
    session[:jump_back_stored_referer] ? redirect_to(clear_referer) : redirect_to(path)
  end

  def clear_referer
    session.delete(:jump_back_stored_referer)
  end
end