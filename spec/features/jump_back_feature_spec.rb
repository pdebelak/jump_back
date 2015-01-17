feature 'jump_back features' do
  describe 'redirect_back' do
    it 'should redirect back' do
      visit save_path
      click_button 'Post to redirect_with_options'
      expect(page).to have_content('Save Path')
    end
  end
  
  describe 'return_to_referer' do
    it 'should return to saved referer' do
      visit clear_and_save_path
      click_link 'Go to save page'
      visit blank_path
      click_button 'Put to return_with_options'
      expect(page).to have_content('Clear and Save Path')
    end
    
    it 'should not reset referer if not cleared' do
      visit clear_and_save_path
      click_link 'Go to save page'
      visit blank_path
      click_link 'Go to save page'
      visit blank_path
      click_button 'Put to return_with_options'
      expect(page).to have_content('Clear and Save Path')
    end
    
    it 'should reset referer if cleared' do
      visit clear_and_save_path
      click_link 'Go to save page'
      click_link 'Go to edit page'
      visit blank_path
      click_button 'Put to return_with_options'
      expect(page).to have_content('Save Path')
    end
  end
end