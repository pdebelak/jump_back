describe TestsController, type: :controller do

  describe 'redirect_back' do
    
    it 'should redirect to default with no referer and no arguments' do
      post :create
      expect(response).to redirect_to(root_path)
    end
    
    it 'should redirect to the supplied path with no referer' do
      delete :destroy, id: 1
      expect(response).to redirect_to(new_test_path)
    end
    
    it 'should redirect back with a referer' do
      @request.env['HTTP_REFERER'] = test_path(1)
      post :create
      expect(response).to redirect_to(test_path(1))
      delete :destroy, id: 2
      expect(response).to redirect_to(test_path(1))
    end
    
    it 'should not redirect back when the referer is offsite' do
      @request.env['HTTP_REFERER'] = 'http://rubyonrails.org/'
      post :create
      expect(response).to redirect_to(root_path)
      delete :destroy, id: 1
      expect(response).to redirect_to(new_test_path)
    end
    
    it 'should redirect back when referer is offsite with offsite set to true' do
      @request.env['HTTP_REFERER'] = 'http://rubyonrails.org/'
      get :offsite_with_default
      expect(response).to redirect_to('http://rubyonrails.org/')
    end
    
    it 'should redirect back when referer is offsite with offsite set to true with no path argument' do
      @request.env['HTTP_REFERER'] = 'http://rubyonrails.org/'
      get :offsite_without_default
      expect(response).to redirect_to('http://rubyonrails.org/')
    end
    
    it 'should work normally with no referer if offsite is true' do
      get :offsite_with_default
      expect(response).to redirect_to(new_test_path)
      get :offsite_without_default
      expect(response).to redirect_to(root_path)
    end
  end
  
  describe 'save_referer' do
    
    it 'should save the referer in the session' do
      @request.env['HTTP_REFERER'] = test_path(1)
      get :new
      expect(session[:jump_back_stored_referer]).to eq(test_path(1))
    end
    
    it 'should not overwrite the referer once saved' do
      @request.env['HTTP_REFERER'] = test_path(1)
      get :new
      @request.env['HTTP_REFERER'] = new_test_path
      get :new
      expect(session[:jump_back_stored_referer]).to eq(test_path(1))
    end
  end
  
  describe 'clear_referer' do
    
    it 'should remove the stored referer' do
      @request.env['HTTP_REFERER'] = test_path(1)
      get :new
      expect(session[:jump_back_stored_referer]).to eq(test_path(1))
      delete :destroy, id: 1
      expect(session[:jump_back_stored_referer]).to be_nil
    end
    
    it 'should remove the stored referer so it can be written' do
      @request.env['HTTP_REFERER'] = test_path(1)
      get :new
      expect(session[:jump_back_stored_referer]).to eq(test_path(1))
      @request.env['HTTP_REFERER'] = new_test_path
      get :edit, id: 1
      expect(session[:jump_back_stored_referer]).to eq(new_test_path)
    end
  end
  
  describe 'return_to_referer' do
    it 'should redirect to saved referer' do
      @request.env['HTTP_REFERER'] = test_path(1)
      get :new
      put :update, id: 1
      expect(response).to redirect_to(test_path(1))
    end
    
    it 'should redirect to saved referer even with actions in between' do
      @request.env['HTTP_REFERER'] = test_path(1)
      get :new
      post :create
      put :update, id: 1
      expect(response).to redirect_to(test_path(1))
    end
    
    it 'should delete the stored referer' do
      @request.env['HTTP_REFERER'] = test_path(1)
      get :new
      expect(session[:jump_back_stored_referer]).to eq(test_path(1))
      put :update, id: 1
      expect(session[:jump_back_stored_referer]).to be_nil
    end
    
    it 'should redirect to default with no referer and no arguments' do
      put :update, id: 1
      expect(response).to redirect_to(root_path)
    end
    
    it 'should redirect to argument with no referer' do
      get :show, id: 1
      expect(response).to redirect_to(new_test_path)
    end
  end
end