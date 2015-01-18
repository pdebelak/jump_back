feature 'view helpers' do
  
  describe 'link_back' do

    it 'creates a link back to referer' do
      visit clear_and_save_path
      click_link 'Go to save page'
      click_link 'back'
      expect(current_path).to eq(clear_and_save_path)
    end
    
    it 'links to default with no referer' do
      visit save_path
      click_link 'back'
      expect(current_path).to eq(root_path)
    end
    
    it 'links to provided path with no referer' do
      visit blank_path
      click_link 'back'
      expect(current_path).to eq(clear_and_save_path)
    end
    
    it 'ignores provided path if referer exists' do
      visit save_path
      click_link 'Go to blank page'
      click_link 'back'
      expect(current_path).to eq(save_path)
    end
    
    describe 'arguments' do
    
      it 'accepts a name argument' do
        visit clear_and_save_path
        expect(page).to have_link('Go back from whence you came!')
      end
      
      it 'accepts both name and path arguments' do
        visit blank_path
        click_link 'A back link'
        expect(current_path).to eq(save_path)
      end
      
      it 'accepts additional link_to options' do
        visit clear_and_save_path
        expect(page).to have_css('a.red', text: 'back')
      end
      
      it 'accepts additional link_to options with a name but no path' do
        visit clear_and_save_path
        expect(page).to have_css('a#just-name[data-remote=true]', text: 'Just a name!')
      end
      
      it 'accepts additional link_to options with a path but no name' do
        visit clear_and_save_path
        expect(page).to have_css('a[href="/tests/save"][data-method=put]', text: 'back')
      end
      
      it 'accepts all three arguments' do
        visit clear_and_save_path
        expect(page).to have_css('a#all-options[href="/tests/save"]', text: 'All options!')
      end
      
      it 'handles an href as text if a default argument exists' do
        visit clear_and_save_path
        expect(page).to have_css('a[href="/tests/save"]', text: 'http://localhost:3000/tests/clear_and_save')
      end
    end
    
    context 'with an offsite referer' do
    
      it 'doesn\'t link back to offsite referers' do
        Capybara.current_session.driver.header 'Referer', 'http://rubyonrails.org/'
        visit clear_and_save_path
        click_link 'Go back from whence you came!'
        expect(current_path).to eq(root_path)
      end
      
      it 'links back to offsite referers with offsite flag' do
        Capybara.current_session.driver.header 'Referer', 'http://rubyonrails.org/'
        visit clear_and_save_path
        click_link 'Offsite okay!'
        expect(current_url).to eq('http://rubyonrails.org/')
      end
    end
  end
end