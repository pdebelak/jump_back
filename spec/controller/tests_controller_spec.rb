describe TestsController, type: :controller do

  describe 'redirect_back' do
    
    it 'should redirect to default with no referer and no arguments' do
      post :redirect_with_options
      expect(response).to redirect_to(root_path)
    end
    
    it 'should redirect to the supplied path with no referer' do
      delete :clear_and_redirect
      expect(response).to redirect_to(save_path)
    end
    
    it 'should redirect back with a referer' do
      @request.env['HTTP_REFERER'] = return_with_path_path
      post :redirect_with_options
      expect(response).to redirect_to(return_with_path_path)
      delete :clear_and_redirect
      expect(response).to redirect_to(return_with_path_path)
    end
    
    it 'should not redirect back when the referer is offsite' do
      @request.env['HTTP_REFERER'] = 'http://rubyonrails.org/'
      post :redirect_with_options
      expect(response).to redirect_to(root_path)
      delete :clear_and_redirect
      expect(response).to redirect_to(save_path)
    end
    
    it 'should redirect back when referer is offsite with offsite set to true' do
      @request.env['HTTP_REFERER'] = 'http://rubyonrails.org/'
      get :offsite_with_path
      expect(response).to redirect_to('http://rubyonrails.org/')
    end
    
    it 'should redirect back when referer is offsite with offsite set to true with no path argument' do
      @request.env['HTTP_REFERER'] = 'http://rubyonrails.org/'
      get :offsite
      expect(response).to redirect_to('http://rubyonrails.org/')
    end
    
    it 'should work normally with no referer if offsite is true' do
      get :offsite_with_path
      expect(response).to redirect_to(save_path)
      get :offsite
      expect(response).to redirect_to(root_path)
    end
    
    it 'should pass additional options to redirect_to' do
      post :redirect_with_options
      expect(flash[:notice]).to eq('Created!')
      expect(response.status).to eq(301)
    end
    
    it 'should pass additional options with offsite set to true with path specified and a referer' do
      @request.env['HTTP_REFERER'] = 'http://rubyonrails.org/'
      get :offsite_with_path
      expect(response).to redirect_to('http://rubyonrails.org/')
      expect(flash[:alert]).to eq('Offsite with default!')
    end
    
    it 'should pass additional options with offsite set to true without path specified and a referer' do
      @request.env['HTTP_REFERER'] = 'http://rubyonrails.org/'
      get :offsite
      expect(response).to redirect_to('http://rubyonrails.org/')
      expect(flash[:alert]).to eq('Offsite without default!')
    end
    
    it 'should pass additional options with offsite set to true with path specified and no referer' do
      get :offsite_with_path
      expect(response).to redirect_to(save_path)
      expect(flash[:alert]).to eq('Offsite with default!')
    end
    
    it 'should pass additional options with offsite set to true without path specified and no referer' do
      get :offsite
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Offsite without default!')
    end
  end
  
  describe 'save_referer' do
    
    it 'should save the referer in the session' do
      @request.env['HTTP_REFERER'] = return_with_path_path
      get :save
      expect(session[:jump_back_stored_referer]).to eq(return_with_path_path)
    end
    
    it 'should not overwrite the referer once saved' do
      @request.env['HTTP_REFERER'] = return_with_path_path
      get :save
      @request.env['HTTP_REFERER'] = save_path
      get :save
      expect(session[:jump_back_stored_referer]).to eq(return_with_path_path)
    end
  end
  
  describe 'clear_referer' do
    
    it 'should remove the stored referer' do
      @request.env['HTTP_REFERER'] = return_with_path_path
      get :save
      expect(session[:jump_back_stored_referer]).to eq(return_with_path_path)
      delete :clear_and_redirect
      expect(session[:jump_back_stored_referer]).to be_nil
    end
    
    it 'should remove the stored referer so it can be written' do
      @request.env['HTTP_REFERER'] = return_with_path_path
      get :save
      expect(session[:jump_back_stored_referer]).to eq(return_with_path_path)
      @request.env['HTTP_REFERER'] = save_path
      get :clear_and_save
      expect(session[:jump_back_stored_referer]).to eq(save_path)
    end
  end
  
  describe 'return_to_referer' do
    it 'should redirect to saved referer' do
      @request.env['HTTP_REFERER'] = return_with_path_path
      get :save
      put :return_with_options
      expect(response).to redirect_to(return_with_path_path)
    end
    
    it 'should redirect to saved referer even with actions in between' do
      @request.env['HTTP_REFERER'] = return_with_path_path
      get :save
      post :redirect_with_options
      put :return_with_options
      expect(response).to redirect_to(return_with_path_path)
    end
    
    it 'should delete the stored referer' do
      @request.env['HTTP_REFERER'] = return_with_path_path
      get :save
      expect(session[:jump_back_stored_referer]).to eq(return_with_path_path)
      put :return_with_options
      expect(session[:jump_back_stored_referer]).to be_nil
    end
    
    it 'should redirect to default with no referer and no arguments' do
      put :return_with_options
      expect(response).to redirect_to(root_path)
    end
    
    it 'should redirect to argument with no referer' do
      get :return_with_path
      expect(response).to redirect_to(save_path)
    end
    
    it 'should pass options to redirect_to with a path specified' do
      get :return_with_path
      expect(flash[:alert]).to eq('Go away!')
      expect(response.status).to eq(301)
    end
    
    it 'should pass options to redirect_to without a path specified' do
      put :return_with_options
      expect(flash[:notice]).to eq('Updated!')
      expect(response.status).to eq(302)
    end
  end
end