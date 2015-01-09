class TestsController < ApplicationController
  def index
  end

  def show
    return_to_referer new_test_path
  end

  def new
    save_referer
  end

  def create
    redirect_back
  end

  def edit
    clear_referer
    save_referer
  end

  def update
    return_to_referer
  end

  def destroy
    clear_referer
    redirect_back new_test_path
  end
  
  def offsite_with_default
    redirect_back new_test_path, offsite: true
  end
  
  def offsite_without_default
    redirect_back offsite: true
  end
end