class TestsController < ApplicationController
  def blank
  end

  def return_with_path
    return_to_referer save_path, alert: 'Go away!', status: 301
  end

  def save
    save_referer
  end

  def redirect_with_options
    redirect_back notice: 'Created!', status: :moved_permanently
  end

  def clear_and_save
    clear_referer
    save_referer
  end

  def return_with_options
    return_to_referer notice: 'Updated!', status: 302
  end

  def clear_and_redirect
    clear_referer
    redirect_back save_path
  end
  
  def offsite_with_path
    redirect_back save_path, offsite: true, alert: 'Offsite with default!'
  end
  
  def offsite
    redirect_back offsite: true, alert: 'Offsite without default!'
  end
end