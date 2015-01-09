feature 'jump_back features' do
  describe 'redirect_back' do
    it 'should redirect back' do
      visit new_test_path
      click_button 'New test'
      expect(page).to have_content('New Page')
    end
  end
  
  describe 'return_to_referer' do
    it 'should return to saved referer' do
      visit edit_test_path(1)
      click_link 'Go to new page'
      visit tests_path
      click_button 'Update test'
      expect(page).to have_content('Edit Page')
    end
    
    it 'should not reset referer if not cleared' do
      visit edit_test_path(1)
      click_link 'Go to new page'
      visit tests_path
      click_link 'Go to new page'
      visit tests_path
      click_button 'Update test'
      expect(page).to have_content('Edit Page')
    end
    
    it 'should reset referer if cleared' do
      visit edit_test_path(1)
      click_link 'Go to new page'
      click_link 'Go to edit page'
      visit tests_path
      click_button 'Update test'
      expect(page).to have_content('New Page')
    end
  end
end