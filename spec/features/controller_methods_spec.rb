feature 'controller methods' do
  describe 'redirect_back' do
    it 'redirects back' do
      visit save_path
      click_button 'Post to redirect_with_options'
      expect(current_path).to eq(save_path)
    end
  end
  
  describe 'return_to_referer' do
    it 'returns to saved referer' do
      visit clear_and_save_path
      click_link 'Go to save page'
      visit blank_path
      click_button 'Put to return_with_options'
      expect(current_path).to eq(clear_and_save_path)
    end
    
    it 'doesn\'t reset referer if not cleared' do
      visit clear_and_save_path
      click_link 'Go to save page'
      visit blank_path
      click_link 'Go to save page'
      visit blank_path
      click_button 'Put to return_with_options'
      expect(current_path).to eq(clear_and_save_path)
    end
    
    it 'resets referer if cleared' do
      visit clear_and_save_path
      click_link 'Go to save page'
      click_link 'Go to edit page'
      visit blank_path
      click_button 'Put to return_with_options'
      expect(current_path).to eq(save_path)
    end
  end
end